require 'rails_helper'

RSpec.describe "/dealerships", type: :feature do
  describe "as a visitor, when I visit the dealership index page" do
    before :each do 
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @dealership_3 = Dealership.create!(name: "Mom and Pop Auto Shop", financing_available: false, employees: 2)
      visit "/dealerships"
    end
    it "should display the name of each dealerships" do
      expect(page).to have_content(@dealership_1.name)
      expect(page).to have_content(@dealership_2.name)
      expect(page).to have_content(@dealership_3.name)
    end

    it "should be ordered starting with most recently created" do
      expect(@dealership_3.name).to appear_before(@dealership_2.name)
      expect(@dealership_2.name).to appear_before(@dealership_1.name)
    end

    it "should display created at timestamps" do
      expect(page).to have_content(@dealership_1.created_at)
      expect(page).to have_content(@dealership_2.created_at)
      expect(page).to have_content(@dealership_3.created_at)
    end

    it 'should have a link to the cars index at the top' do
      expect(page).to have_link("View all cars.")
      click_link("View all cars.")

      expect(current_path).to eq("/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      expect(page).to have_link("View all dealerships.")
      click_link "View all dealerships."

      expect(current_path).to eq("/dealerships")
    end

    it 'should have a link to a page where you can create a dealership' do
      expect(page).to have_link("New dealership.")
      click_link "New dealership."

      expect(current_path).to eq("/dealerships/new")
    end

    it 'should have a link next to each dealership to edit its info' do
        expect(page).to have_link("Edit #{@dealership_1.name}.")
        click_link "Edit #{@dealership_1.name}."
        expect(current_path).to eq("/dealerships/#{@dealership_1.id}/edit")

        visit "/dealerships"
        expect(page).to have_link("Edit #{@dealership_2.name}.")
        click_link "Edit #{@dealership_2.name}."
        expect(current_path).to eq("/dealerships/#{@dealership_2.id}/edit")

        visit "/dealerships"
        expect(page).to have_link("Edit #{@dealership_3.name}.")
        click_link "Edit #{@dealership_3.name}."
        expect(current_path).to eq("/dealerships/#{@dealership_3.id}/edit")
    end

    it 'should have a link next to each dealership to delete it' do
      expect(page).to have_link("Delete #{@dealership_1.name}.")
      click_link "Delete #{@dealership_1.name}."
      expect(current_path).to eq('/dealerships')
      expect(page).to have_no_content(@dealership_1.name)
      
      expect(page).to have_link("Delete #{@dealership_2.name}.")
      click_link "Delete #{@dealership_2.name}."
      expect(current_path).to eq('/dealerships')
      expect(page).to have_no_content(@dealership_2.name)
      
      expect(page).to have_link("Delete #{@dealership_3.name}.")
      click_link "Delete #{@dealership_3.name}."
      expect(current_path).to eq('/dealerships')
      expect(page).to have_no_content(@dealership_3.name)
    end
    
    it 'deletes cars when their parent dealership is deleted' do
      @car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: true, mileage: 30200, dealership_id: @dealership_1.id)
      @car_2 = Car.create!(make: 'Nissan', model: 'Rogue', awd: true, mileage: 46414, dealership_id: @dealership_1.id)
      @car_3 = Car.create!(make: 'Porsche', model: '911', awd: true, mileage: 160234, dealership_id: @dealership_2.id)
      click_link "Delete #{@dealership_1.name}."
      
      visit "/cars"
      expect(page).to have_no_content(@car_1.make)
      expect(page).to have_no_content(@car_1.model)
      expect(page).to have_no_content(@car_1.mileage)

      expect(page).to have_no_content(@car_2.make)
      expect(page).to have_no_content(@car_2.model)
      expect(page).to have_no_content(@car_2.mileage)

      expect(page).to have_content(@car_3.make)
      expect(page).to have_content(@car_3.model)
      expect(page).to have_content(@car_3.mileage)
    end

    it 'has links to each of the dealerships show pages' do
      expect(page).to have_link("#{@dealership_1.name}", exact: true)
      click_link("#{@dealership_1.name}")
      expect(current_path).to eq("/dealerships/#{@dealership_1.id}")

      visit "/dealerships"
      expect(page).to have_link("#{@dealership_2.name}", exact: true)
      click_link("#{@dealership_2.name}")
      expect(current_path).to eq("/dealerships/#{@dealership_2.id}")
    end
  end
end