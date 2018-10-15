class Fill < ApplicationRecord
  belongs_to :car

  def ppm_to_s
    "#{sprintf('%.1f', ppm)} pence per mile"
  end

  def mpg_to_s
    "#{sprintf('%.1f', mpg)} miles per gallon"
  end

  def gallons
    litres / 4.546
  end

  private

  def litres
    self.total_price * 100 / self.price_per_litre
  end

  def ppm
    total_price * 100 / self.miles_on_trip
  end

  def mpg
    self.miles_on_trip / gallons
  end

end
