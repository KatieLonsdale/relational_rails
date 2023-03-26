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

    it 'should have a link to the child index at the top' do
      visit "/dealerships/#{@dealership_1.id}"

      expect(page).to have_link("Click here to view all cars.")
      click_link("Click here to view all cars.")

      expect(current_url).to eq("http://www.example.com/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      visit "/dealerships/#{@dealership_1.id}"

      expect(page).to have_link("Click here to view all dealerships.")
      click_link "Click here to view all dealerships."

      expect(current_url).to eq("http://www.example.com/dealerships")
    end

    it 'should have a link to the index of cars that belong to dealership' do
      visit "/dealerships/#{@dealership_1.id}"
      expect(page).to have_link("Click here to view this dealership's inventory.")
      click_link "Click here to view this dealership's inventory."
      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealership_1.id}/cars")

      visit "/dealerships/#{@dealership_2.id}"
      expect(page).to have_link("Click here to view this dealership's inventory.")
      click_link "Click here to view this dealership's inventory."
      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealership_2.id}/cars")
    end

    it 'has a link to update the dealership' do
      visit "/dealerships/#{@dealership_1.id}"
      expect(page).to have_link("Update Dealership.")
      click_link "Update Dealership."
      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealership_1.id}/edit")

      visit "/dealerships/#{@dealership_2.id}"
      expect(page).to have_link("Update Dealership.")
      click_link "Update Dealership."
      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealership_2.id}/edit")
    end

    it 'has a link to delete the dealership' do
      visit "/dealerships/#{@dealership_1.id}"
      expect(page).to have_link("Delete Dealership.")
      click_link "Delete Dealership."
      expect(current_path).to eq('/dealerships')
      expect(page).to have_no_content(@dealership_1.name)
    end

    it 'deletes cars when their parent dealership is deleted' do
      visit "/dealerships/#{@dealership_1.id}"
      click_link "Delete Dealership."

      visit "/cars"
      expect(page).to have_no_content(@car_1.make)
      expect(page).to have_no_content(@car_1.model)
      expect(page).to have_no_content(@car_1.mileage)

      expect(page).to have_no_content(@car_4.make)
      expect(page).to have_no_content(@car_4.model)
      expect(page).to have_no_content(@car_4.mileage)

      expect(page).to have_content(@car_5.make)
      expect(page).to have_content(@car_5.model)
      expect(page).to have_content(@car_5.mileage)
    end
  end
end