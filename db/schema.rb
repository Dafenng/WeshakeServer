# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131114013032) do

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favors", force: true do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "message"
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_photos", force: true do |t|
    t.string   "photo_type"
    t.string   "photo_url"
    t.string   "size_type"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "shops", force: true do |t|
    t.string   "extern_id"
    t.string   "addr"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.string   "genre_info"
    t.string   "tel"
    t.string   "access"
    t.string   "open_time"
    t.string   "holiday"
    t.string   "lunch_budget"
    t.integer  "lunch_budget_average"
    t.string   "dinner_budget"
    t.integer  "dinner_budget_average"
    t.float    "rating"
    t.string   "region"
    t.string   "area"
    t.string   "district"
    t.string   "shop_type"
    t.string   "genre"
    t.string   "cuisine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_square_image"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "avatar"
    t.string   "auth_token"
    t.string   "user_type"
    t.string   "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
