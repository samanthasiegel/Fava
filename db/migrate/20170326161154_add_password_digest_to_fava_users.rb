class AddPasswordDigestToFavaUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :fava_users, :password_digest, :string
  end
end
