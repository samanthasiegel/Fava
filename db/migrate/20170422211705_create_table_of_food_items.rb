class CreateTableOfFoodItems < ActiveRecord::Migration[5.0]
  def change
    create_table :food_items do |t|
      t.references :restaurant, foreign_key: true
      t.string :food_name
      t.string :description
      t.string :category
      t.string :price
      t.string :allergy_info
      t.integer :dietary_info
    end
  end
end
