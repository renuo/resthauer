require 'rails_helper'

RSpec.describe 'GraphSchema' do
  let!(:menu) { Menu.create!(title: 'Gulasch', price: '9.80', description: 'das ist gut.') }
  let!(:user) { User.create!(name: 'Alessandro', email: 'a@renuo.ch', auth_token: '1234') }
  let!(:rating) { Rating.create!(value: 1, menu: menu, user: user) }

  it 'can query a menu title' do
    query = <<~GRAPHQL
    {
      menu(id: #{menu.id}) {
        id
        title
        price
        description
      }
    }
    GRAPHQL

    result = GraphSchema.execute(query)
    expect(result['data']['menu']['id']).to eq(menu.id.to_s)
    expect(result['data']['menu']['title']).to eq(menu.title)
    expect(result['data']['menu']['price']).to eq(menu.price.to_f)
    expect(result['data']['menu']['description']).to eq(menu.description)
  end

  it 'can query all ratings for a menu' do
    query = <<~GRAPHQL
    {
      menu(id: #{menu.id}) {
        id
        ratings {
          value
        }
      }
    }
    GRAPHQL

    result = GraphSchema.execute(query)
    expect(result['data']['menu']['ratings']).to be_an(Enumerable)
    expect(result['data']['menu']['ratings'].first['value']).to be(1)
  end

  it 'can query all users who rated a menu' do
    query = <<~GRAPHQL
    {
      menu(id: #{menu.id}) {
        id
        ratings {
          value
          user {
            name
          }
        }
      }
    }
    GRAPHQL

    result = GraphSchema.execute(query)
    expect(result['data']['menu']['ratings']).to be_an(Enumerable)
    expect(result['data']['menu']['ratings'].first['value']).to be(1)
    expect(result['data']['menu']['ratings'].first['user']['name']).to eq('Alessandro')
  end
end
