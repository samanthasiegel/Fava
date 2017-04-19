class AddColumnRestToFoodItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :food_items, :rest, :integer
  end
end
