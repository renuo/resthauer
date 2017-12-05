require 'rails_helper'

RSpec.describe Reishauer do
  subject { described_class.new }

  let(:monday) { Time.zone.local(2016, 11, 28) }
  let(:tuesday) { monday + 1.day }
  let(:thursday) { monday + 3.days }
  let(:friday) { monday + 4.days }

  it 'has a method :update' do
    expect(subject).to respond_to(:update).with(0).arguments
  end

  describe '#update' do
    let(:server_response) { File.open('spec/data/sample_response.html') }

    before do
      allow_any_instance_of(Kernel).to receive(:open).with('https://clients.eurest.ch/de/reishauer/wallisellen/menu')
        .and_return(server_response)
      Timecop.freeze thursday
    end

    after do
      Timecop.return
    end

    context 'there are already menus for today' do
      it 'does not fetch menus from the website' do
        Menu.create(date: thursday)
        expect_any_instance_of(Kernel).not_to receive(:open)
        subject.update
      end
    end

    it 'persists all the meals' do
      subject.update
      expect(Menu.all.count).to eq 15
    end

    it 'persists the three menus for monday' do
      subject.update
      monday_menu = Menu.where('DATE(date) = ?', monday)
      expect(monday_menu.count).to eq 3
    end

    it 'persists the three menus for friday' do
      subject.update
      friday_menu = Menu.where('DATE(date) = ?', friday)
      expect(friday_menu.count).to eq 3
    end

    describe 'menu 1 on tuesday' do
      let(:menu1) { Menu.find_by(title: 'Spaghetti bolognese') }

      before do
        subject.update
      end

      it 'is persisted' do
        expect(menu1).to be_a Menu
      end

      it 'has the correct date' do
        expect(menu1.date).to eq tuesday
      end

      it 'has the correct price' do
        expect(menu1.price.to_f).to eq 9.8
      end

      it 'has the correct description' do
        expect(menu1.description).to eq 'Rindshackfleisch(CH) dazu Reibkäse, Menusalat'
      end
    end
  end
end
