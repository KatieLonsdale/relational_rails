require 'rails_helper'

RSpec.describe "/cars", type: :feature do
  describe "as a visitor, when I visit the car index page" do
    it "should display each car and its attributes" do
      dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)

      car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: dealership_1.id)
      car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: dealership_2.id)
      car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: dealership_3.id)
      visit "/cars"

      save_and_open_page

      expect(page).to have_content(car_1.make)
      expect(page).to have_content(car_1.model)
      expect(page).to have_content(car_1.awd)
      expect(page).to have_content(car_1.mileage)

      expect(page).to have_content(car_2.make)
      expect(page).to have_content(car_2.model)
      expect(page).to have_content(car_2.awd)
      expect(page).to have_content(car_2.mileage)

      expect(page).to have_content(car_3.make)
      expect(page).to have_content(car_3.model)
      expect(page).to have_content(car_3.awd)
      expect(page).to have_content(car_3.mileage)
    end
  end
end