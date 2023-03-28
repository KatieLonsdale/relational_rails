class DealershipsController < ApplicationController
  def index
    @dealerships = Dealership.dealerships_by_created_at
  end

  def show
    @dealership = Dealership.find(params[:id])
  end

  def new
  end

  def create
    dealership = Dealership.new(dealership_params)
    dealership.save
    redirect_to '/dealerships'
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
  end

  def update
    dealership = Dealership.find(params[:dealership_id])
    dealership.update(dealership_params)
    dealership.save
    redirect_to "/dealerships/#{dealership.id}"
  end

  def delete
    dealership = Dealership.find(params[:dealership_id])
    cars = dealership.list_cars(params)
    cars.each{|car| car.destroy}
    dealership.destroy
    redirect_to '/dealerships'
  end

  private
  def dealership_params
    params.permit(:name, :financing_available, :employees)
  end
end