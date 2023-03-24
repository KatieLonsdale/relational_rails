require 'rails_helper'

RSpec.describe '/dealerships/:dealership_id/edit' do
  describe "as a visitor, when I arrive at the edit dealership page" do
    it 'can edit an existing dealership' do
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      visit "/dealerships/#{@dealership_1.id}/edit"

      fill_in(:name, with: 'Different Dealership Name')
      fill_in(:financing_available, with: false)
      fill_in(:employees, with: 5)
      click_button('Edit Dealership')

      expect(current_path).to eq("/dealerships/#{@dealership_1.id}")
      expect(page).to have_content("Different Dealership Name")
      expect(page).to have_content("false")
      expect(page).to have_content("5")
    end
  end
end