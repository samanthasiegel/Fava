class ChangePriceToFloatFoodItems < ActiveRecord::Migration[5.0]
  def change
  	change_column :food_items, :price, :float
  end
end
