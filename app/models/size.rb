class Size < ApplicationRecord
	validates :size_descr, presence: true
	has_one :food_item
	validates :price, presence:true, numericality: true
	validates :full_descr, presence:true


# Check there exists associated food item
  def valid_food_item_id
  	if FoodItem.find_by_id(food_item_id).nil?
  		p "Food item for this side does not exist"
  		errors.add(:food_item, "Food item for this size does not exist")
  	end
  end

	def format_price()
	    string_tip = price.to_s
	    if string_tip.index('.') == -1
	      string_tip += '.00'
	    elsif string_tip.index('.') == string_tip.size - 2
	      string_tip += '0'
	    end
	    return string_tip
  	end

end
