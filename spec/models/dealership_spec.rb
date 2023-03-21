require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'relationships' do
    it {should have_many :cars}
  end
end