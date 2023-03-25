require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'relationships' do
    it { should belong_to(:dealership) }
  end

  describe '::class methods' do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)

      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_2.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_3.id)
      @car_4 = Car.create!(make: 'Subaru', model: 'Outback', awd: true, mileage: 250234, dealership_id: @dealership_2.id)
    end
    describe '::cars_with_awd' do
      it 'returns an array of cars with awd' do
        assert(Car.cars_with_awd, [@car2, @car_4])
      end
    end
  end
end