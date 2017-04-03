class Side < ApplicationRecord
  has_one :food_item
  validates :options, presence:true
end
