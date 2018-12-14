class Car < ApplicationRecord
  has_many :fills

  def ppm_to_s
    "#{sprintf('%.1f', ppm)} lifetime pence per mile"
  end

  def mpg_to_s
    "#{sprintf('%.1f', mpg)} lifetime miles per gallon"
  end

  def fill_ups
    count = 1
    fills_hash = {}
    self.fills.order(:created_at).each_with_index do |fill, index|
      fill_hash = {}
      fill_hash[:number_of_fills] = count
      fill_hash[:ppm] = fill.ppm
      fill_hash[:mpg] = fill.mpg
      fills_hash[index] = fill_hash

      fill.fill_to_neck ? count = 1 : count += 1
      
    end
    fills_hash
  end

  # index

  # fill_count
  # filled - bool
  # ppm
  # mpg

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
