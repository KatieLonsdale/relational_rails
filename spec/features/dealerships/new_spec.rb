require 'rails_helper'

RSpec.describe '/dealerships/new' do
  describe "as a visitor, when I arrive at the create new dealership page" do
    it 'can create a new dealership' do
      visit '/dealerships/new'

      fill_in(:name, with: 'County Line Auto')
      fill_in(:financing_available, with: true)
      fill_in(:employees, with: 10)
      click_button('Create Dealership')

      expect(current_path).to eq("/dealerships")
      expect(page).to have_content("County Line Auto")
    end
  end
end