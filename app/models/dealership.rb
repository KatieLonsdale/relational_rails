class Dealership < ApplicationRecord
  has_many :cars

  def self.dealerships_by_created_at
    Dealership.all.order(created_at: :desc)
  end

  def count_of_cars
    cars.count
  end

  def list_cars(params)
    dealership_cars = Car.where(dealership_id: id)
    if params[:sort] == "alphabetically"
      @cars = dealership_cars.sort_alphabetically
    elsif params[:commit] == "Filter"
      @cars = dealership_cars.filter_by_mileage(params[:mileage])
    else
      @cars = dealership_cars.all
    end
  end
end