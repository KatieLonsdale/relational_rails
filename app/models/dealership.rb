class Dealership < ApplicationRecord
  has_many :cars

  def list_cars(params)
    if params[:sort] == "alphabetically"
      @cars = Car.sort_alphabetically
    else
      @cars = Car.all
    end
  end

  def count_of_cars
    cars.count
  end
end