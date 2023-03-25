class Car < ApplicationRecord
  belongs_to :dealership

  def self.cars_with_awd
    Car.where(awd: true)
  end

  def self.sort_alphabetically
    Car.order(:make, :model)
  end
end