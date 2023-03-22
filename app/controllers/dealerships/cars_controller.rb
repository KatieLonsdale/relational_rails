  class Dealerships::CarsController < ApplicationController
    def index
      @dealership = Dealership.find(params[:dealership_id])
    end
  end
