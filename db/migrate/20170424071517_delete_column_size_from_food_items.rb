class DeleteColumnSizeFromFoodItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :food_items, :size
  end
end
