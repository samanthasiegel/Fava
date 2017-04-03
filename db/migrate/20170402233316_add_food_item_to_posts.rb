class AddFoodItemToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :food_item, foreign_key: true
  end
end
