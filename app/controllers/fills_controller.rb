class FillsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @fill = Fill.new
  end

  def create
    @fill = Fill.new(fill_params)

    if @fill.save
      flash[:notice] = "Saved!"
      redirect_to root_path
    else
      flash[:alert] = "Nope!"
      redirect_to root_path
    end
  end

  def fill_params
    params.require(:fill).permit(:car_id, :price_per_litre, :total_price, :miles_on_trip, :fill_to_neck)
  end
end