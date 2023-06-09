require 'rails_helper'

RSpec.describe "/cars", type: :feature do
  describe "as a visitor, when I visit the car index page" do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)

      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_2.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: false, mileage: 160234, dealership_id: @dealership_3.id)
      @car_4 = Car.create!(make: 'Subaru', model: 'Outback', awd: true, mileage: 250234, dealership_id: @dealership_2.id)

      visit "/cars"
    end
    it "should display each car and its attributes" do
      expect(page).to have_content(@car_2.make)
      expect(page).to have_content(@car_2.model)
      expect(page).to have_content(@car_2.awd)
      expect(page).to have_content(@car_2.mileage)

      expect(page).to have_content(@car_4.make)
      expect(page).to have_content(@car_4.model)
      expect(page).to have_content(@car_4.awd)
      expect(page).to have_content(@car_4.mileage)
    end

    it 'should have a link to the cars index at the top' do
      expect(page).to have_link("View all cars.")
      click_link "View all cars."
      expect(current_path).to eq("/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      expect(page).to have_link("View all dealerships.")
      click_link "View all dealerships."
      expect(current_path).to eq("/dealerships")
    end

    it 'should only show cars with awd' do
      expect(page).to have_no_content(@car_1.make)
      expect(page).to have_no_content(@car_1.model)
      expect(page).to have_no_content(@car_1.awd)
      expect(page).to have_no_content(@car_1.mileage)

      expect(page).to have_content(@car_2.make)
      expect(page).to have_content(@car_2.model)
      expect(page).to have_content(@car_2.awd)
      expect(page).to have_content(@car_2.mileage)

      expect(page).to have_no_content(@car_3.make)
      expect(page).to have_no_content(@car_3.model)
      expect(page).to have_no_content(@car_3.awd)
      expect(page).to have_no_content(@car_3.mileage)

      expect(page).to have_content(@car_4.make)
      expect(page).to have_content(@car_4.model)
      expect(page).to have_content(@car_4.awd)
      expect(page).to have_content(@car_4.mileage)
    end

    it 'should have a link next to each car to edit its info' do
      expect(page).to have_link("Edit #{@car_2.make} #{@car_2.model}.")
      click_link "Edit #{@car_2.make} #{@car_2.model}."
      expect(current_path).to eq("/cars/#{@car_2.id}/edit")

      visit "/cars"
      expect(page).to have_link("Edit #{@car_4.make} #{@car_4.model}.")
      click_link "Edit #{@car_4.make} #{@car_4.model}."
      expect(current_path).to eq("/cars/#{@car_4.id}/edit")
    end

    it 'should have a link next to each car to delete its info' do
      expect(page).to have_link("Delete #{@car_2.make} #{@car_2.model}.")
      click_link "Delete #{@car_2.make} #{@car_2.model}."
      expect(current_path).to eq('/cars')
      expect(page).to have_no_content(@car_2.make)
      expect(page).to have_no_content(@car_2.model)
      expect(page).to have_no_content(@car_2.mileage)
      expect(page).to have_content(@car_4.make)
      expect(page).to have_content(@car_4.model)
      expect(page).to have_content(@car_4.mileage)

      expect(page).to have_link("Delete #{@car_4.make} #{@car_4.model}.")
      click_link "Delete #{@car_4.make} #{@car_4.model}."
      expect(current_path).to eq('/cars')
      expect(page).to have_no_content(@car_4.make)
      expect(page).to have_no_content(@car_4.model)
      expect(page).to have_no_content(@car_4.mileage)
    end

    it 'has links to each cars show page' do
      expect(page).to have_link("#{@car_2.make} #{@car_2.model}", exact: true)
      click_link("#{@car_2.make} #{@car_2.model}")
      expect(current_path).to eq("/cars/#{@car_2.id}")

      visit "/cars"
      expect(page).to have_link("#{@car_4.make} #{@car_4.model}", exact: true)
      click_link("#{@car_4.make} #{@car_4.model}")
      expect(current_path).to eq("/cars/#{@car_4.id}")
    end
  end
end