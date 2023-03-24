require 'rails_helper'

RSpec.describe '/cars/:car_id/edit' do
  describe "as a visitor, when I arrive at the edit car page" do
    it 'can edit an existing car' do
      dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      car_1 = Car.create!(make: 'Toyota', model: 'Corolla', awd: false, mileage: 30200, dealership_id: dealership_1.id)
      
      visit "/cars/#{car_1.id}/edit"

      fill_in(:make, with: 'Subaru')
      fill_in(:model, with: 'Outback')
      fill_in(:awd, with: true)
      fill_in(:mileage, with: 147023)

      click_button('Edit Car')

      expect(current_path).to eq("/cars/#{car_1.id}")
      expect(page).to have_content('Subaru')
      expect(page).to have_content('Outback')
      expect(page).to have_content('true')
      expect(page).to have_content('147023')
    end
  end
end