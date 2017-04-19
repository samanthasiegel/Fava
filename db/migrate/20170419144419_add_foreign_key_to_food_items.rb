class AddForeignKeyToFoodItems < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :food_items, :restaurants
  end
end
