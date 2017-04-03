class FoodItem < ApplicationRecord
	has_one :restaurant
	has_many :sides
	validates :food_name, presence:true
	validates :price, presence:true, :numericality => true
	validates :category, presence:true
	validates :allergy_info, presence:true
	validates :dietary_info, presence:true, :numericality => true
	validate :dietary_info_format
	#validate :unique_at_restaurant
	# validates_uniqueness_of :food_name, :scope => :Restaurant_id


	def dietary_info_format
		if dietary_info < 0 or dietary_info > 2
			errors.add(:dietary_info, "invalid dietary info code submitted incorrectly")
		end
	end

	# def unique_at_restaurant
	# 	other_food = FoodItem.where(:food_name => food_name)
	# 	if other_food.size > 0 and other_food.first.Restaurant_id == Restaurant_id
	# 		errors.add(:restaurant, "restaurant already has this food")
	# 	end
	# end




end
