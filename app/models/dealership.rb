class Dealership < ApplicationRecord
  has_many :cars

  def list_cars(params)
    dealership_cars = Car.where(dealership_id: id)
    if params[:sort] == "alphabetically"
      @cars = dealership_cars.sort_alphabetically
    else
      @cars = dealership_cars.all
    end
  end

  def count_of_cars
    cars.count
  end
end