class AddFavaPointsToFavaUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fava_users, :fava_points, :integer
  end
end
