class Restaurant < ApplicationRecord
	validates :name, presence: true, uniqueness: {case_sensitive: false}
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

end
