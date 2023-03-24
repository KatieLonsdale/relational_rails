class DealershipsController < ApplicationController
  def index
    @dealerships = Dealership.all.order(created_at: :desc)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end

  def new
  end

  def create
    dealership = Dealership.new({
      name: params[:name],
      financing_available: params[:financing_available],
      employees: params[:employees]
    })
    dealership.save
    redirect_to '/dealerships'
  end

  def edit
    @dealership=Dealership.find(params[:dealership_id])
  end

  def update
    dealership = Dealership.find(params[:dealership_id])
    dealership.update({
    name: params[:name],
    financing_available: params[:financing_available],
    employees: params[:employees]
    })
    dealership.save
    redirect_to "/dealerships/#{dealership.id}"
  end

end