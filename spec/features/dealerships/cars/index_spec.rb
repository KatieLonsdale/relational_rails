require 'rails_helper'

RSpec.describe "/dealerships/:id/cars", type: :feature do
  describe "as a visitor, when I visit the cars page for a dealership" do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_2.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_2.id)
      @car_4 = Car.create!(make: 'Toyota', model: 'Highlander', awd: true, mileage: 80854, dealership_id: @dealership_1.id)
      @car_5 = Car.create!(make: 'Jeep', model: 'Cherokee', awd: true, mileage: 67053, dealership_id: @dealership_2.id)
      @car_6 = Car.create!(make: 'Jeep', model: 'Grand Cherokee', awd: true, mileage: 20431, dealership_id: @dealership_2.id)
      @car_7 = Car.create!(make: 'Ford', model: 'Bronco', awd: true, mileage: 204393, dealership_id: @dealership_1.id)
    end
    it "should display the cars that belong to dealership with that id and their attriburtes" do
      visit "/dealerships/#{@dealership_1.id}/cars"

      expect(page).to have_content(@car_1.make)
      expect(page).to have_content(@car_1.model)
      expect(page).to have_content(@car_1.awd)
      expect(page).to have_content(@car_1.mileage)
      expect(page).to have_content(@car_4.make)
      expect(page).to have_content(@car_4.model)
      expect(page).to have_content(@car_4.awd)
      expect(page).to have_content(@car_4.mileage)

      expect(page).to have_no_content(@car_2.make)
      expect(page).to have_no_content(@car_2.model)
      expect(page).to have_no_content(@car_2.mileage)

      visit "/dealerships/#{@dealership_2.id}/cars"

      expect(page).to have_content(@car_2.make)
      expect(page).to have_content(@car_2.model)
      expect(page).to have_content(@car_2.awd)
      expect(page).to have_content(@car_2.mileage)
      expect(page).to have_content(@car_3.make)
      expect(page).to have_content(@car_3.model)
      expect(page).to have_content(@car_3.awd)
      expect(page).to have_content(@car_3.mileage)
      expect(page).to have_content(@car_5.make)
      expect(page).to have_content(@car_5.model)
      expect(page).to have_content(@car_5.awd)
      expect(page).to have_content(@car_5.mileage)

      expect(page).to have_no_content(@car_4.make)
      expect(page).to have_no_content(@car_4.model)
      expect(page).to have_no_content(@car_4.mileage)
    end

    it 'should have a link to the cars index at the top' do
      visit "/dealerships/#{@dealership_1.id}/cars"

      expect(page).to have_content("Click here to view all cars.")
      click_link "Click here to view all cars."

      expect(current_url).to eq("http://www.example.com/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      visit "/dealerships/#{@dealership_1.id}/cars"

      expect(page).to have_content("Click here to view all dealerships.")
      click_link "Click here to view all dealerships."

      expect(current_url).to eq("http://www.example.com/dealerships")
    end

    it 'should have a link to add a new car for that dealership' do
      visit "/dealerships/#{@dealership_1.id}/cars"
      expect(page).to have_content("Add a new car.")
      click_link "Add a new car."

      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealership_1.id}/cars/new")
    end

    it 'should have a link to sort cars in alphabetical order' do
      visit "/dealerships/#{@dealership_2.id}/cars"
      expect(page).to have_content("Sort in alphabetical order.")
      click_link "Sort in alphabetical order."

      expect(current_path).to eq("/dealerships/#{@dealership_2.id}/cars")
      expect(@car_5.make).to appear_before(@car_2.make)
      expect(@car_2.make).to appear_before(@car_3.make)
    end
    
    it 'should sort alphabetically by model if make is the same' do
      visit "/dealerships/#{@dealership_1.id}/cars"
      click_link "Sort in alphabetical order."

      expect(current_path).to eq("/dealerships/#{@dealership_1.id}/cars")
      expect(@car_1.model).to appear_before(@car_4.model)

      visit "/dealerships/#{@dealership_2.id}/cars"
      click_link "Sort in alphabetical order."

      expect(@car_5.model).to appear_before(@car_6.model)
    end
  end
end