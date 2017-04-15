class Request < ApplicationRecord
  has_one :fava_user
  has_one :food_item

  validates :tip, presence:true, numericality:true
  validates :status, presence:true
  validate :status_range
  validates :notes, length: { maximum: 250 }
  validates :location, presence:true

  def status_range
  	if status < 0 or status >= 4
  		errors.add(:status, 'status must be in range 0-4 inclusive')
  	end
  end

  def diff_poster_claimer
  	if :fava_user_id == :claimer
  		errors.add(:claimer, 'cannot claim own post')
  	end
  end

  def get_food_name
    return FoodItem.find_by_id(:food_item_id)
  end

  def get_food_name
    return FoodItem.find_by_id(food_item_id).food_name
  end

  def get_user_name
    user = FavaUser.find_by_id(fava_user_id)
    return user.first_name + " " + user.last_name
  end

  def get_restaurant_name
    food_item = FoodItem.find_by_id(food_item_id)
    return Restaurant.find_by_id(food_item.Restaurant_id).name
  end

  def get_food_price
    food_item = FoodItem.find_by_id(food_item_id)
    return food_item.price
  end

  def format_float(value)
    string_tip = value.to_s
    if string_tip.index('.') == -1
      string_tip += '.00'
    elsif string_tip.index('.') == string_tip.size - 2
      string_tip += '0'
    end
    return string_tip
  end

  def get_total_cost
    price = FoodItem.find_by_id(food_item_id).price
    return price + tip
  end




end

