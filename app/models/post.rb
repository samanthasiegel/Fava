class Post < ApplicationRecord
  before_save :generate_timestamp

  def generate_timestamp
    self.timestamp = DateTime.now
  end
  # Rails automatically creates id
  belongs_to :poster, class_name: 'fava_user'
  validates :poster, presence: true
  #belongs_to :claimer, class_name: 'fava_user', optional: true, , -> { where claimer != poster }
  has_many :food_item
  validates :food_item, presence: true # Change to has_one if we want to limit to one item for each order?
  has_one :restaurant
  validates :food_item, presence: true
  validates :cost, presence: true, numericality: true
  validates :tip, numericality: true
  validates :post_timestamp, presence: true
  validates :status, presence: true
  validate :status_range
  validates :notes, length: { maximum: 250 }

  def status_range
    errors.add(:status, 'status must be in range 0-4 inclusive') if (status < 0 || status > 4)
  end

  def poster_claimer_distinct
    errors.add(:usersIndistinct, "poster can't be claimer") if poster == claimer
  end


#  CREATE TABLE Post
#  (
#  post_id INTEGER NOT NULL PRIMARY KEY,
#  poster_uid INTEGER NOT NULL REFERENCES User(uid) CHECK(SELECT verified FROM Users WHERE Users.uid = poster_uid),
#  claimer_uid INTEGER REFERENCES User(uid) CHECK(claimer_uid <> poster_uid and (SELECT verified FROM Users WHERE Users.uid = claimer_uid)),
#  food_id INTEGER NOT NULL REFERENCES FoodItem(food_id),
#  restaurant_id INTEGER NOT NULL REFERENCES Restaurant(id) CHECK(EXISTS (SELECT * FROM FoodItem WHERE FoodItem.food_id = Post.food_id and FoodItem.restaurant_id = Post.restaurant_id)),
#  cost FLOAT NOT NULL,
#   tip FLOAT NOT NULL,
#   post_timestamp VARCHAR(20) NOT NULL,
#   notes VARCHAR(250),
#   status INTEGER NOT NULL CHECK(status >= 0 and status <= 4)
#   );
end