class Dealership < ApplicationRecord
  has_many :cars

  def list_cars
    cars.each{|car| car}
  end
end