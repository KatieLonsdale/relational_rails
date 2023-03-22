# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes
# (data from each column that is on the child table)

require 'rails_helper'

RSpec.describe "/dealerships/:id/cars", type: :feature do
  describe "as a visitor, when I visit the cars page for a dealership" do
    it "should display the cars that belong to dealership with that id and their attriburtes" do
      dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: dealership_1.id)
      car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: dealership_2.id)
      car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: dealership_2.id)
      car_4 = Car.create!(make: 'Toyota', model: 'Highlander', awd: true, mileage: 80854, dealership_id: dealership_1.id)
      car_5 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: dealership_2.id)
      visit "/dealerships/#{dealership_1.id}/cars"

      expect(page).to have_content(car_1.make)
      expect(page).to have_content(car_1.model)
      expect(page).to have_content(car_1.awd)
      expect(page).to have_content(car_1.mileage)
      expect(page).to have_content(car_4.make)
      expect(page).to have_content(car_4.model)
      expect(page).to have_content(car_4.awd)
      expect(page).to have_content(car_4.mileage)

      visit "/dealerships/#{dealership_2.id}/cars"

      expect(page).to have_content(car_2.make)
      expect(page).to have_content(car_2.model)
      expect(page).to have_content(car_2.awd)
      expect(page).to have_content(car_2.mileage)
      expect(page).to have_content(car_3.make)
      expect(page).to have_content(car_3.model)
      expect(page).to have_content(car_3.awd)
      expect(page).to have_content(car_3.mileage)
      expect(page).to have_content(car_5.make)
      expect(page).to have_content(car_5.model)
      expect(page).to have_content(car_5.awd)
      expect(page).to have_content(car_5.mileage)
    end
  end
end