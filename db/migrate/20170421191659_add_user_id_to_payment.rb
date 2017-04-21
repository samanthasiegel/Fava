class AddUserIdToPayment < ActiveRecord::Migration[5.0]
 def up
    change_table :payments do |t|
      t.integer :user_id 
    end
  end
end
