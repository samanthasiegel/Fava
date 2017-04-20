class AddSizeIdToRequests < ActiveRecord::Migration[5.0]
  def change
  	add_column :requests, :size_id, :integer
  end
end
