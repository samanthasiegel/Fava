class AddPinToFavaUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fava_users, :pin, :string
  end
end
