class DropFoodItem < ActiveRecord::Migration[5.0]
  def change
  	drop_table :food_items
  end
end
