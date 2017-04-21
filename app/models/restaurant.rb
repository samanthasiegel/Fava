class Restaurant < ApplicationRecord
	before_destroy :check_for_food_items
	before_update :check_food_exists
	after_update :check_food_exists
	has_many :food_items
	before_save :update_food_items
	validates :name, presence: true
	validates :location, presence: true
	validates :open_hour, presence:true, length: {is: 4}
	validates :close_hour, presence:true, length: {is: 4}
	validate :time_formatting
	validate :unique_rest

	def time_formatting
		if(open_hour < "0000" or open_hour > "2400")
			errors.add(:open_hour, 'time formatted incorrectly')
		end
		if(close_hour < "0000" or open_hour > "2400")
			errors.add(:close_hour, 'time formatted incorrectly')
		end
	end

	def update_food_items
		food_items = FoodItem.where(:rest => id).all
	end

	def unique_rest
		if Restaurant.where(:name => name, :location => location).all.size > 0
			errors.add(:name, "Restaurant entries must be unique")
		end
	end

# not working for some reason
private
	def check_for_food_items
		if FoodItem.where(:rest => id).size > 0
			errors.add(:food_items, "Cannot destroy restaurant with existing food items")
			return false
		end
	end

	def check_food_exists
		p food_items.first
		if FoodItem.where(:id => id_was).size > 0
			errors.add(:food_items, "Cannot change id of restaurant with existing food items")
			return false
		end
	end

end
