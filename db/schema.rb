# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170422201232) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fava_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "remember_digest"
    t.string   "pin"
    t.float    "fava_points"
  end

  create_table "food_items", force: :cascade do |t|
    t.string  "food_name"
    t.string  "description"
    t.string  "category"
    t.float   "price"
    t.boolean "size"
    t.string  "allergy_info"
    t.integer "dietary_info"
    t.integer "Restaurant_id"
    t.integer "rest"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "method"
    t.string   "card_name"
    t.string   "card_number"
    t.integer  "card_CVC"
    t.integer  "card_expiry_month"
    t.integer  "card_expiry_year"
    t.float    "amount"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.integer  "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "poster"
    t.integer  "claimer"
    t.integer  "food_item"
    t.decimal  "tip"
    t.string   "notes"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "fava_user_id"
    t.integer  "food_item_id"
    t.index ["fava_user_id"], name: "index_posts_on_fava_user_id"
    t.index ["food_item_id"], name: "index_posts_on_food_item_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "fava_user_id"
    t.integer  "food_item_id"
    t.float    "tip"
    t.string   "notes"
    t.string   "location"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "claimer"
    t.integer  "side_id"
    t.integer  "size_id"
    t.index ["fava_user_id"], name: "index_requests_on_fava_user_id"
    t.index ["food_item_id"], name: "index_requests_on_food_item_id"
    t.index ["side_id"], name: "index_requests_on_side_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "open_hour"
    t.string   "close_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_restaurants_on_name"
  end

  create_table "sides", force: :cascade do |t|
    t.integer  "food_item_id"
    t.string   "options"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["food_item_id"], name: "index_sides_on_food_item_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string   "size_descr"
    t.integer  "food_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "price"
    t.string   "full_descr"
    t.index ["food_item_id"], name: "index_sizes_on_food_item_id"
  end

end
