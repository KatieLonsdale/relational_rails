require 'rails_helper'

RSpec.describe "/dealership/:id", type: :feature do
  before :each do 
    @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
    @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
    @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
    @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_2.id)
    @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_2.id)
    @car_4 = Car.create!(make: 'Toyota', model: 'Highlander', awd: true, mileage: 80854, dealership_id: @dealership_1.id)
    @car_5 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: @dealership_2.id)
    
  end
  describe "as a visitor, when I visit the show page" do
    it "should display the dealership with that id and the dealership's attributes" do
      visit "/dealerships/#{@dealership_1.id}"
      
      expect(page).to have_content(@dealership_1.name)
      expect(page).to have_content(@dealership_1.financing_available)
      expect(page).to have_content(@dealership_1.employees)
    end
    
    it "shows a count of cars each dealership has" do
      visit "/dealerships/#{@dealership_1.id}"
      expect(page).to have_content("2 cars available")

      visit "/dealerships/#{@dealership_2.id}"
      expect(page).to have_content("3 cars available")
    end
  end
end