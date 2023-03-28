require 'rails_helper'

RSpec.describe '/dealerships/:dealership_id/edit' do
  describe "as a visitor, when I arrive at the edit dealership page" do
    before :each do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 50)
    end
    it 'can edit an existing dealership' do
      visit "/dealerships/#{@dealership_1.id}/edit"

      fill_in(:name, with: 'Different Dealership Name')
      fill_in(:financing_available, with: false)
      fill_in(:employees, with: 5)
      click_button('Edit Dealership')

      expect(current_path).to eq("/dealerships/#{@dealership_1.id}")
      expect(page).to have_content("Different Dealership Name")
      expect(page).to have_content("false")
      expect(page).to have_content("5")

      visit "/dealerships/#{@dealership_2.id}/edit"

      fill_in(:name, with: 'Lonsdale Car Sales')
      fill_in(:financing_available, with: false)
      fill_in(:employees, with: 1)
      click_button('Edit Dealership')

      expect(current_path).to eq("/dealerships/#{@dealership_2.id}")
      expect(page).to have_content("Lonsdale Car Sales")
      expect(page).to have_content("false")
      expect(page).to have_content("1")
    end
  end
end