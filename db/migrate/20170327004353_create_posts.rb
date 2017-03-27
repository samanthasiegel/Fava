class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :poster
      t.integer :claimer
      t.integer :food_item
      t.integer :restaurant
      t.decimal :cost
      t.decimal :tip
      t.string :notes
      t.integer :status
      t.timestamps null: false
    end
  end
end
