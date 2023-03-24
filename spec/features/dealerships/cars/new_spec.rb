require 'rails_helper'

RSpec.describe '/dealerships/:dealership_id/cars/new' do
  describe "as a visitor, when I arrive at the create new car page" do
    it 'can create a new car' do
      dealership = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)

      visit "/dealerships/#{dealership.id}/cars/new"

      fill_in(:make, with: 'Toyota')
      fill_in(:model, with: 'Corolla')
      fill_in(:awd, with: false)
      fill_in(:mileage, with: 37829)

      click_button('Create Car')

      expect(current_path).to eq("/dealerships/#{dealership.id}/cars")
      expect(page).to have_content("Toyota")
      expect(page).to have_content("Corolla")
      expect(page).to have_content("false")
      expect(page).to have_content("37829")
    end
  end
end