class CreateSides < ActiveRecord::Migration[5.0]
  def change
    create_table :sides do |t|
      t.references :food_item, foreign_key: true
      t.string :title
      t.string :options

      t.timestamps
    end
  end
end
