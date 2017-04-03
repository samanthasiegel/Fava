class RemoveTitleFromSide < ActiveRecord::Migration[5.0]
  def change
    remove_column :sides, :title, :string
  end
end
