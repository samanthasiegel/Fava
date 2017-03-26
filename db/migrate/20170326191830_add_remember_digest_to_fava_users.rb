class AddRememberDigestToFavaUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :fava_users, :remember_digest, :string
  end
end
