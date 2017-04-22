class Side < ApplicationRecord
  has_one :food_item
  validates :options, presence:true
  validate :valid_food_item_id

  # Check there exists associated food item
  def valid_food_item_id
  	if FoodItem.find_by_id(food_item_id).nil?
  		p "Food item for this side does not exist"
  		errors.add(:food_item, "Food item for this side " + options + " does not exist")
  	end
  end

end
