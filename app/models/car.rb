class Car < ApplicationRecord
  has_many :fills

  def ppm_to_s
    "#{sprintf('%.1f', ppm)} lifetime pence per mile"
  end

  def mpg_to_s
    "#{sprintf('%.1f', mpg)} lifetime miles per gallon"
  end

  private

  def total_spend
    total = 0
    tank_filled = false
    self.fills.order(created_at: 'DESC').each do |fill|
      if !tank_filled && fill.fill_to_neck
        tank_filled = true
      end

      if tank_filled
        total += fill.total_price
      end
    end
    total
  end

  def total_miles
    total = 0
    tank_filled = false
    self.fills.order(created_at: 'DESC').each do |fill|
      if !tank_filled && fill.fill_to_neck
        tank_filled = true
      end

      if tank_filled
        total += fill.miles_on_trip
      end
    end
    total
  end

  def total_gallons
    total = 0
    tank_filled = false
    self.fills.order(created_at: 'DESC').each do |fill|
      if !tank_filled && fill.fill_to_neck
        tank_filled = true
      end

      if tank_filled
        total += fill.gallons
      end
    end
    total
  end

  def ppm
    total_spend * 100 / total_miles
  end

  def mpg
    total_miles / total_gallons
  end

end
