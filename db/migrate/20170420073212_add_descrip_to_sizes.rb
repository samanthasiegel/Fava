class AddDescripToSizes < ActiveRecord::Migration[5.0]
  def change
  	add_column :sizes, :full_descr, :string
  end
end
