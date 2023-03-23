require 'rails_helper'

RSpec.describe "/dealerships", type: :feature do
  describe "as a visitor, when I visit the dealership index page" do
    let(:dealer1) { "Mountain States Toyota" }
    let(:dealer2) { "Stevinson Automotive" }
    let(:dealer3) { "Mom&Pop Auto Shop" }
    before :each do 
      @dealership_1 = Dealership.create!(name: "Mountain States Toyota", financing_available: true, employees: 100)
      @dealership_2 = Dealership.create!(name: "Stevinson Automotive", financing_available: true, employees: 300)
      @dealership_3 = Dealership.create!(name: "Mom&Pop Auto Shop", financing_available: false, employees: 2)
      visit "/dealerships"
    end
    it "should display the name of each dealerships" do
      expect(page).to have_content(@dealership_1.name)
      expect(page).to have_content(@dealership_2.name)
      expect(page).to have_content(@dealership_3.name)
    end

    xit "should be ordered starting with most recently created" do
      save_and_open_page

      expect(:dealer3).to appear_before(:dealer2)
      expect(:dealer2).to appear_before(:dealer1)
    end

    it "should display created at timestamps" do
      save_and_open_page
      expect(page).to have_content(@dealership_1.created_at)
      expect(page).to have_content(@dealership_2.created_at)
      expect(page).to have_content(@dealership_3.created_at)
    end
  end
end

# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created