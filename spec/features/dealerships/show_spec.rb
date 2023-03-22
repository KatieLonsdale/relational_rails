require 'rails_helper'

RSpec.describe "/dealership/:id", type: :feature do
  describe "as a visitor, when I visit the show page" do
    it "should display the dealership with that id and the dealership's attributes" do
      dealership = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)

      visit "/dealerships/#{dealership.id}"

      expect(page).to have_content(dealership.name)
      expect(page).to have_content(dealership.financing_available)
      expect(page).to have_content(dealership.employees)
    end
  end

end