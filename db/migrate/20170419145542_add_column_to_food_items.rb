class AddColumnToFoodItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :food_items, :Restaurant_id, :integer
  end
end
