require 'rails_helper'

RSpec.describe '/dealerships/:dealership_id/cars/new' do
  describe "as a visitor, when I arrive at the create new car page" do
    before :each do 
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 50)
    end
    it 'can create a new car' do
      visit "/dealerships/#{@dealership_1.id}/cars/new"

      fill_in(:make, with: 'Toyota')
      fill_in(:model, with: 'Corolla')
      fill_in(:awd, with: false)
      fill_in(:mileage, with: 37829)

      click_button('Create Car')

      expect(current_path).to eq("/dealerships/#{@dealership_1.id}/cars")
      expect(page).to have_content("Toyota")
      expect(page).to have_content("Corolla")
      expect(page).to have_content("false")
      expect(page).to have_content("37829")

      visit "/dealerships/#{@dealership_2.id}/cars/new"

      fill_in(:make, with: 'Subaru')
      fill_in(:model, with: 'Outback')
      fill_in(:awd, with: true)
      fill_in(:mileage, with: 128342)

      click_button('Create Car')

      expect(current_path).to eq("/dealerships/#{@dealership_2.id}/cars")
      expect(page).to have_content("Subaru")
      expect(page).to have_content("Outback")
      expect(page).to have_content("true")
      expect(page).to have_content("128342")
    end
  end
end