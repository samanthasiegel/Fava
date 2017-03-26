require 'csv'
namespace :import do

	desc "Import restaurants from csv"
	task restaurants: :environment do
		filename = File.join Rails.root, "restaurants.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			name, location, open_hour, close_hour = row
			r = Restaurant.create(name: name, location: location, open_hour: open_hour, close_hour: close_hour) 
			puts "#{name} - #{r.errors.full_messages.join(',')}" if r.errors.any?
			counter += 1 if r.persisted?
		end
		puts "Imported #{counter} restaurants"
	end

	#import food items and connect to restaurants
	desc "Import food items from csv"
	task food_items: :environment do
		filename = File.join Rails.root, "food_items.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			restaurant_id, name, description, category, price, size, allergy_info, dietary_info = row
			f = FoodItem.create(Restaurant_id: restaurant_id, food_name: name, description: description, category: category,
				price: price, size: size, allergy_info: allergy_info, dietary_info: dietary_info)
			puts "#{food_name} - #{f.errors.full_messages.join(',')}" if f.errors.any?
			counter += 1 if f.persisted?
		end
		puts "Imported #{counter} food items"
	end

end