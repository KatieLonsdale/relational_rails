  class Dealerships::CarsController < ApplicationController
    def index
      @dealership = Dealership.find(params[:dealership_id])
      @cars = @dealership.list_cars(params)
    end

    def new
      @dealership = Dealership.find(params[:dealership_id])
    end

    def create
      car = Car.new(car_params)
      car.save
      redirect_to "/dealerships/#{params[:dealership_id]}/cars"
    end

    private
    def car_params
      params.permit(:make, :model, :awd, :mileage, :dealership_id)
    end
  end
