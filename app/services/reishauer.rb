require 'open-uri'
require 'nokogiri'

class Reishauer
  def update
    return if Menu.find_by(date: Time.zone.today).present?
    update_meals
  end

  private

  def update_meals
    Nokogiri::HTML(html_menu_content).css('.menu-section').each do |section|
      update_meal(section)
    end
  end

  def update_meal(section)
    section.children.css('.meal').each_with_index do |meal, i|
      create_meal_object(meal.children, i)
    end
  end

  def create_meal_object(meal_node, weekday_index)
    Menu.create(title: meal_node.css('h3').text,
                price: meal_node.css('dd.price').text.gsub(/CHF[^\d]*(.*)/, '\1'),
                description: meal_node.css('div.meal-description').text.strip,
                date: (monday + weekday_index.days))
  end

  def monday
    @monday ||= Time.zone.today.monday
  end

  def html_menu_content
    open('https://clients.eurest.ch/de/reishauer/wallisellen/menu')
  end
end
