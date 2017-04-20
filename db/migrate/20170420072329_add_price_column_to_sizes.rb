class AddPriceColumnToSizes < ActiveRecord::Migration[5.0]
  def change
  	add_column :sizes, :price, :float
  end
end
