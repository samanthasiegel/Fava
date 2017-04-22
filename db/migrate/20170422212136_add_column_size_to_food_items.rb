class AddColumnSizeToFoodItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :food_items, :size, :boolean
  end
end
