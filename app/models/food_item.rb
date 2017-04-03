class FoodItem < ApplicationRecord
	has_one :restaurant
	validates :food_name, presence:true
	validates :price, presence:true, :numericality => true
	validates :category, presence:true
	validates :allergy_info, presence:true
	validates :dietary_info, presence:true, :numericality => true
	validate :dietary_info_format
	validates_uniqueness_of :food_name, :scope => :Restaurant_id


	def dietary_info_format
		if dietary_info < 0 or dietary_info > 2
			errors.add(:dietary_info, "invalid dietary info code submitted incorrectly")
		end
	end



end
