require 'rails_helper'

RSpec.describe "/cars/:id", type: :feature do
  describe "as a visitor, when I visit the car show page" do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)

      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_2.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_3.id)
      @car_4 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: @dealership_2.id)
    end
    it "should display car with that id and its attributes" do
      visit "/cars/#{@car_1.id}"

      expect(page).to have_content(@car_1.make)
      expect(page).to have_content(@car_1.model)
      expect(page).to have_content(@car_1.awd)
      expect(page).to have_content(@car_1.mileage)

      visit "/cars/#{@car_2.id}"

      expect(page).to have_content(@car_2.make)
      expect(page).to have_content(@car_2.model)
      expect(page).to have_content(@car_2.awd)
      expect(page).to have_content(@car_2.mileage)

      visit "/cars/#{@car_3.id}"

      expect(page).to have_content(@car_3.make)
      expect(page).to have_content(@car_3.model)
      expect(page).to have_content(@car_3.awd)
      expect(page).to have_content(@car_3.mileage)
    end

    it 'should have a link to the cars index at the top' do
      visit "/cars/#{@car_1.id}"

      expect(page).to have_link("View all cars.")
      click_link "View all cars."

      expect(current_path).to eq("/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      visit "/cars/#{@car_1.id}"

      expect(page).to have_link("View all dealerships.")
      click_link "View all dealerships."

      expect(current_path).to eq("/dealerships")
    end

    it 'has a link to update the car' do
      visit "/cars/#{@car_1.id}"

      expect(page).to have_link("Update Car.")
      click_link "Update Car."
      
      expect(current_path).to eq("/cars/#{@car_1.id}/edit")
    end

    it 'has a link to delete the car' do
      visit "/cars/#{@car_1.id}"
      expect(page).to have_link("Delete Car.")
      click_link "Delete Car."
      expect(current_path).to eq('/cars')
      expect(page).to have_no_content(@car_1.model)

      visit "/cars/#{@car_2.id}"
      expect(page).to have_link("Delete Car.")
      click_link "Delete Car."
      expect(current_path).to eq('/cars')
      expect(page).to have_no_content(@car_2.model)
      expect(page).to have_content(@car_4.make)
      expect(page).to have_content(@car_4.model)
      expect(page).to have_content(@car_4.mileage)
    end
  end
end