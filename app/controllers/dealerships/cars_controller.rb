  class Dealerships::CarsController < ApplicationController
    def index
      @dealership = Dealership.find(params[:dealership_id])
    end

    def new
      @dealership = Dealership.find(params[:dealership_id])
    end

    def create
      car = Car.new({
        make: params[:make],
        model: params[:model],
        awd: params[:awd],
        mileage: params[:mileage],
        dealership_id: params[:dealership_id]
      })
      car.save
      redirect_to "/dealerships/#{params[:dealership_id]}/cars"
    end
  end
