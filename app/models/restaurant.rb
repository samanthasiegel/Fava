class Restaurant < ApplicationRecord
	# Restaurant associated to many food items
	has_many :food_items

	# Checks that restaurant is unique (by name and location)
	before_create :unique_rest

	# Prevents updating/destroying restaurants with existing food items
	before_destroy :check_food_before_destroy
	before_update :check_food_exists
	validate :check_food_exists

	# Data entry validation
	validates :name, presence: true
	validates :location, presence: true
	validates :open_hour, presence:true, length: {is: 4}
	validates :close_hour, presence:true, length: {is: 4}
	validate :time_formatting

	def time_formatting
		if(open_hour < "0000" or open_hour > "2400")
			errors.add(:open_hour, 'time formatted incorrectly')
		end
		if(close_hour < "0000" or open_hour > "2400")
			errors.add(:close_hour, 'time formatted incorrectly')
		end
	end

	def unique_rest
		if Restaurant.where(:name => name, :location => location).all.size > 0
			errors.add(:name, "Restaurant entries must be unique")
		end
	end

	def check_food_exists
		if id_was != id and food_items.size > 0
			p "Cannot change id of restaurant with existing food items"
			errors.add(:food_items, "Cannot change id of restaurant with existing food items")
			return false
		end
	end

	# deletes all food upon destroy
	def check_food_before_destroy
		if food_items.size > 0
			for i in 0..food_items.size-1
				FoodItem.destroy(food_items[i].id)
			end
		end
	end

end
