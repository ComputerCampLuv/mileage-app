class CreateFills < ActiveRecord::Migration[5.2]
  def change
    create_table :fills do |t|
      t.decimal :price_per_litre, precision: 4, scale: 1
      t.decimal :total_price, precision: 4, scale: 2
      t.decimal :miles_on_trip, precision: 6, scale: 1
      t.boolean :fill_to_neck
      t.belongs_to :car, foreign_key: true

      t.timestamps
    end
  end
end
