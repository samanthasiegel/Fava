class CreateSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.string :size_descr
      t.references :food_item, foreign_key: true
      t.timestamps
    end
  end
end
