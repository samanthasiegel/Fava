class ChangePriceFormatInFoodItems < ActiveRecord::Migration[5.0]
  def up
  	change_column :food_items, :price, :float
  end

  def down
  	change_column :food_items, :price, :string
  end
end
