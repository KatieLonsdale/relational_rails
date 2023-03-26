require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'relationships' do
    it { should belong_to(:dealership) }
  end

  describe '::class methods' do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)

      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_1.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_1.id)
      @car_4 = Car.create!(make: 'Toyota', model: 'Highlander', awd: true, mileage: 80854, dealership_id: @dealership_1.id)
      @car_5 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: @dealership_1.id)
    end
    describe '::cars_with_awd' do
      it 'returns an array of cars with awd' do
        results = Car.cars_with_awd
        expected = [@car_2, @car_4, @car_5]
        assert_equal(results, expected)
      end
    end
    describe '::sort_alphabetically' do
      it 'returns an array of cars sorted by alphabetical order' do
        results = Car.sort_alphabetically
        expected = [@car_5,@car_2,@car_3,@car_1,@car_4]
        assert_equal(results, expected)
      end
    end
    describe '::filter_by_mileage' do
      it 'returns an array of cars that are above given mileage' do
        results = Car.filter_by_mileage("80,000")
        expected = [@car_3, @car_4]
        assert_equal(results, expected)
      end
    end
  end
end