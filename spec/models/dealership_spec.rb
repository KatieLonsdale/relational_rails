require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'relationships' do
    it { should have_many :cars }
  end

  describe "#cars" do
    it "returns all cars for given dealership" do
      dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: dealership_1.id)
      car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: dealership_2.id)
      car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: dealership_2.id)
      car_4 = Car.create!(make: 'Toyota', model: 'Highlander', awd: true, mileage: 80854, dealership_id: dealership_1.id)
      car_5 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: dealership_2.id)

      expect(dealership_1.list_cars).to eq([car_1, car_4])
      expect(dealership_2.list_cars).to eq([car_2, car_3, car_5])
    end
  end
end