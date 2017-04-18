class ChangeFavaPoints < ActiveRecord::Migration[5.0]
  def change
  	change_column :fava_users, :fava_points, :float
  end
end
