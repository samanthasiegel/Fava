class AddActivationToFavaUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :fava_users, :activation_digest, :string
  	add_column :fava_users, :activated, :boolean, default: false
  	add_column :fava_users, :activated_at, :datetime
  end
end
