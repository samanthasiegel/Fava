class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :fava_user, foreign_key: true
      t.references :food_item, foreign_key: true
      t.float :tip
      t.string :notes
      t.string :location
      t.integer :status

      t.timestamps
    end
  end
end
