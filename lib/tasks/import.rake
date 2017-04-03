require 'csv'
namespace :import do

	desc "Import restaurants from csv"
	task restaurants: :environment do
		filename = File.join Rails.root, "restaurants.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			r_id, name, location, open_hour, close_hour = row
			r = Restaurant.new(name: name, location: location, open_hour: open_hour, close_hour: close_hour) 
			r.id = r_id
			r.save!
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
			f_id, restaurant, food_name, description, category, price, size, allergy_info, dietary_info = row
			f = FoodItem.new(Restaurant_id: restaurant, food_name: food_name, description: description, category: category,
				price: price, size: size, allergy_info: allergy_info, dietary_info: dietary_info)
			f.id = f_id
			f.save!
			puts "#{food_name} - #{f.errors.full_messages.join(',')}" if f.errors.any?
			counter += 1 if f.persisted?
		end
		puts "Imported #{counter} food items"
	end

	desc "Import sides from csv"
	task sides: :environment do
		filename = File.join Rails.root, "sides.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			s_id, food_id, options = row
			s = Side.new(food_item_id: food_id, options: options)
			s.id = s_id
			s.save!
			puts "#{options} - #{s.errors.full_messages.join(',')}" if s.errors.any?
			counter += 1 if s.persisted?
		end
		puts "Imported #{counter} sides"
	end

end