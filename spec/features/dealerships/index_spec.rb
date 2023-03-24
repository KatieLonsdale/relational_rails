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
      expect(page).to have_content("Click here to view all cars.")
      click_link("Click here to view all cars.")

      expect(current_url).to eq("http://www.example.com/cars")
    end

    it 'should have a link to the dealerships index at the top' do
      expect(page).to have_content("Click here to view all dealerships.")
      click_link "Click here to view all dealerships."

      expect(current_url).to eq("http://www.example.com/dealerships")
    end
  end
end