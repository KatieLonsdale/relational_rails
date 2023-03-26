class CarsController < ApplicationController
  def index
    @cars = Car.cars_with_awd
  end

  def show
    @car = Car.find(params[:id])
  end

  def edit
    @car=Car.find(params[:id])
  end

  def update
    car = Car.find(params[:car_id])
    car.update({
    make: params[:make],
    model: params[:model],
    awd: params[:awd],
    mileage: params[:mileage]
    })
    car.save
    redirect_to "/cars/#{car.id}"
  end

  def delete
    car = Car.find(params[:car_id])
    car.destroy
    redirect_to '/cars'
  end
end