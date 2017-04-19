class RemoveIndexFromFoodItems < ActiveRecord::Migration[5.0]
  def change
  	remove_index :food_items, :Restaurant_id
  end
end
