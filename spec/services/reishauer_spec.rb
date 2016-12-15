require 'rails_helper'

RSpec.describe Reishauer do
  describe '#update' do
    it 'is callable' do
      expect(described_class.new).to respond_to(:update).with(0).arguments
    end
  end
end
