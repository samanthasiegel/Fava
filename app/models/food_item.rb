class FoodItem < ApplicationRecord

	has_many :sides
	has_many :sizes
	has_one :restaurant
	validates :food_name, presence:true
	validates :price, presence:true, :numericality => true
	validates :category, presence:true
	validates :allergy_info, presence:true
	validates :dietary_info, presence:true, :numericality => true
	validate :dietary_info_format

	# checks that restaurant exists
	validate :check_restaurant

	#checks uniqueness of food item at its restaurant
	validate :unique_at_restaurant

	# Prevents updating/destroying food items with existing sides or sizes
	before_destroy :remove_all_sides_and_sizes
	before_update :check_sides_or_sizes
	validate :check_sides_or_sizes


	# checks valid input for dietary_info
	# 0 --> no info
	# 1 --> vegetarian
	# 2 --> vegan
	def dietary_info_format
		if dietary_info < 0 or dietary_info > 2
			errors.add(:dietary_info, "invalid dietary info code submitted incorrectly")
		end
	end

	# Check food item doesn't have sides or sizes before changing ID
	def check_sides_or_sizes 
		if id_was != id and (Side.where(:food_item_id => id_was).all.size > 0 || Size.where(:food_item_id => id_was).all.size > 0)
			p "Cannot change id of food item with existing sides or sizes"
			errors.add(:food_items, "Cannot change id of food item with existing sides or sizes")
			return false
		end
		return true
	end

	# Removes all associated sides and sizes upon destroy
	def remove_all_sides_and_sizes
		for i in 0..sides.size-1
			Side.find(sides[i].id).destroy
		end
		for j in 0..sizes.size-1
			Size.find(sizes[j].id).destroy
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

  	def check_restaurant
  		if Restaurant.find_by_id(restaurant_id).nil?
  		 	errors.add(:restaurant_id, 'restaurant does not exist')
  		end
  	end

	def unique_at_restaurant
		FoodItem.where(:food_name => food_name).all.each do |f|
			if id_was == id and f.id != id and f.restaurant_id == restaurant_id
				errors.add(:restaurant_id, 'not a unique entry for this restaurant')
			end
		end
		
	end




end
