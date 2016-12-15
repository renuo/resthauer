require 'open-uri'
require 'nokogiri'

class Reishauer
# frozen_string_literal: true
  MENU = 0
  VEGETARIAN = 1
  DAILY_SPECIAL = 2

  def initialize
    @parsed_html = Nokogiri::HTML(html_menu_content)
  end

  def update
    return if Menu.find_by(date:Date.today).present?
    update_meal(Reishauer::MENU)
    update_meal(Reishauer::VEGETARIAN)
    update_meal(Reishauer::DAILY_SPECIAL)
  end

  def update_meal(menu_type)
    monday = Date.today.monday
    (0..4).each do |i|
      meal_node = menu_type(menu_type).css('.meal').at(i).children
      date = monday + i.days
      create_meal_object(meal_node, date)
    end
  end

  private

  def create_meal_object(meal_node, date)
    Menu.create(title: meal_node.css('h3').text,
                price: meal_node.css('dd.price').text.gsub(/CHF[^\d]*(.*)/, '\1'),
                description: meal_node.css('div.meal-description').text.strip,
                date: date)
  end

  def menu_type(type)
    @parsed_html.css('.menu-section').at(type).children
  end

  def html_menu_content
    open('https://clients.eurest.ch/de/reishauer/wallisellen/menu')
  end
end
