class ChangeSizeInFoodItems < ActiveRecord::Migration[5.0]
  def change
  	change_column :food_items, :size, :boolean
  end
end
