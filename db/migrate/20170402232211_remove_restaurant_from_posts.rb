class RemoveRestaurantFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :restaurant, :integer
  end
end
