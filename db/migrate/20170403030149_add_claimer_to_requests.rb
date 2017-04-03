class AddClaimerToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :claimer, :integer
  end
end
