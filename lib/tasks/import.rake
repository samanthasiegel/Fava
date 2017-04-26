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

	desc "Import restaurants_balt from csv"
	task restaurants_balt: :environment do
		filename = File.join Rails.root, "restaurants_balt.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			name, zip, neighborhood, council, politce, location = row
			r = Restaurant.new(name: name, location: location, open_hour: "0000", close_hour: "2400") 
			r.save!
			puts "#{name} - #{r.errors.full_messages.join(',')}" if r.errors.any?
			counter += 1 if r.persisted?
		end
		puts "Imported #{counter} restaurants"
	end

	desc "Import restaurants_wake from csv"
	task restaurants_wake: :environment do
		filename = File.join Rails.root, "restaurants_wake.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			oid, hsid, name, location = row
			r = Restaurant.new(name: name, location: location, open_hour: "0000", close_hour: "2400") 
			r.save!
			puts "#{name} - #{r.errors.full_messages.join(',')}" if r.errors.any?
			counter += 1 if r.persisted?
		end
		puts "Imported #{counter} restaurants"
	end

	desc "Import food_inspection_restaurants from csv"
	task food_inspection_restaurants: :environment do
		filename = File.join Rails.root, "food_inspection_restaurants.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			iid, name, aka_name, license, facility, risk, location = row
			r = Restaurant.new(name: name, location: location, open_hour: "0000", close_hour: "2400")
			if Restaurant.where(:name => name, :location => location).all.size == 0
				r.save!
				puts "#{name} - #{r.errors.full_messages.join(',')}" if r.errors.any?
				counter += 1 if r.persisted?
			end
		end
		puts "Imported #{counter} restaurants"
	end

	#import food items and connect to restaurants
	desc "Import food items from csv"
	task food_items: :environment do
		filename = File.join Rails.root, "food_items2.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			f_id, restaurant, food_name, description, category, price, size, allergy_info, dietary_info = row
			f = FoodItem.new(restaurant_id: restaurant, food_name: food_name, description: description, category: category,
				price: price, allergy_info: allergy_info, dietary_info: dietary_info)
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

	desc "Import sizes from csv"
	task sizes: :environment do
		filename = File.join Rails.root, "sizes.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			s_id, food_id, descr, price = row
			full = descr + " ($" + price.to_s + ")"
			s = Size.new(food_item_id: food_id, size_descr: descr, price: price, full_descr: full)
			s.id = s_id
			s.save!
			puts "#{descr} - #{s.errors.full_messages.join(',')}" if s.errors.any?
			counter += 1 if s.persisted?
		end
		puts "Imported #{counter} sizes"
	end

	desc "Import categories from csv"
	task categories: :environment do
		filename = File.join Rails.root, "categories.csv"
		counter = 0;
		CSV.foreach(filename) do |row|
			c_id, c_name = row
			c = Category.new(name: c_name)
			c.id = c_id
			c.save!
			puts "#{c_name} - #{c.errors.full_messages.join(',')}" if c.errors.any?
			counter += 1 if c.persisted?
		end
		puts "Imported #{counter} categories"
	end

	desc "Import food_inspection_restaurants from csv"
	task food_inspection_restaurants: :environment do
		filename = File.join Rails.root, "food_inspection_restaurants.csv"
		counter = 0;
		sameNameCount = 0
		CSV.foreach(filename) do |row|
			iid, name, aka_name, license, facility, risk, location = row
			if name != nil and location != nil
				r = Restaurant.new(name: name, location: location, open_hour: "0000", close_hour: "2400")
				puts name
				if Restaurant.where('lower(name) = ?', name.downcase).or(Restaurant.where('lower(location) = ?', location.downcase)).all.size == 0
					r.save!
					puts "#{name} - #{r.errors.full_messages.join(',')}" if r.errors.any?
					counter += 1 if r.persisted?
					puts counter
				else 
					puts sameNameCount
					sameNameCount += 1
				end
			end
		end
		puts "Imported #{counter} restaurants"
		puts "#{sameNameCount} restaurants weren't imported"
	end

	# has_many :sides
	# validates :food_name, presence:true
	# validates :price, presence:true, :numericality => true
	# validates :category, presence:true
	# validates :allergy_info, presence:true
	# validates :dietary_info, presence:true, :numericality => true
	# validate :dietary_info_format

	# # checks that restaurant exists
	# validate :check_restaurant

	# #checks uniqueness of food item at its restaurant
	# validate :unique_at_restaurant

	desc "Import dish_items from csv"
	task dish_items: :environment do
		filename = File.join Rails.root, "dish_items.csv"
		counter = 0;
		sameNameCount = 0
		CSV.foreach(filename).with_index do |row, i|
			# if i < 90000
			# 	next
			# end
			id, name, description, menus_appeared, times_appeared, 
			first_appeared, last_appeared, low_price, high_price = row
			if name != nil and low_price != nil and high_price != nil and (Float(low_price) rescue false)
				low_price_float = Float(low_price)
				high_price_float = Float(high_price)
				average_price = (low_price_float + high_price_float)/2
				r = Restaurant.where('lower(name) = ?', 'dba name').first
				r_id = r.id
				f = FoodItem.new(rest: r_id, food_name: name, description: description, category: "Old Timey",
				price: average_price, allergy_info: "\N", dietary_info: 0)
				if FoodItem.where('lower(food_name) = ?', name.downcase).all.size == 0
					f.save!
					puts "#{name} - #{r.errors.full_messages.join(',')}" if f.errors.any?
					counter += 1 if f.persisted?
					puts counter
				else 
					puts "Same Name: #{sameNameCount}"
					sameNameCount += 1
				end
			end
		end
		puts "Imported #{counter} restaurants"
		puts "#{sameNameCount} restaurants weren't imported"
	end

end