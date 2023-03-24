class DealershipsController < ApplicationController
  def index
    @dealerships = Dealership.all.order(created_at: :desc)
  end

  def show
    @dealership = Dealership.find(params[:id])
  end

  def new
    
  end

  # def create
  #   dealership = Dealership.new({
  #     title: params[:task][:title],
  #     description: params[:task][:description]
  #   })
  #   task.save
  #   redirect_to '/tasks'
  # end
end