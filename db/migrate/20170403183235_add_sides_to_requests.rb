class AddSidesToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :side, foreign_key: true
  end
end
