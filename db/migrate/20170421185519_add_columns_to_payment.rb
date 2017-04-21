class AddColumnsToPayment < ActiveRecord::Migration[5.0]
  def up
    change_table :payments do |t|
      t.string :method  
      t.string :card_name  
      t.string :card_number  
      t.integer :card_CVC  
      t.integer :card_expiry_month 
      t.integer :card_expiry_year
      t.float :amount
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code 
    end
  end
end


