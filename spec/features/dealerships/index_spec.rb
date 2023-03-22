require 'rails_helper'

RSpec.describe "/dealerships", type: :feature do
  describe "as a visitor, when I visit the dealership index page" do
    it "should display the name of each dealerships" do
      dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)
      visit "/dealerships"

      expect(page).to have_content(dealership_1.name)
      expect(page).to have_content(dealership_2.name)
      expect(page).to have_content(dealership_3.name)
    end
  end
end