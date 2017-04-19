class RemoveRestaurantIdFromFoodItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :food_items, :Restaurant_id
  end
end
