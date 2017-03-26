# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'restaurants.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# cvs.each do |row|
# 	r = Restaurant.new
# 	r.name = row['name']
# 	r.location = row['location']
# 	r.open_hour = row['open_hour']
# 	r.close_hour = row['close_hour']
# 	r.save
# 	puts '#{r.name} saved'
# end
