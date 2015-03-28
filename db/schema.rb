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

ActiveRecord::Schema.define(version: 20150328153149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "number"
    t.string   "postcode"
    t.integer  "place_id"
    t.integer  "street_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["place_id"], name: "index_addresses_on_place_id", using: :btree
  add_index "addresses", ["street_id"], name: "index_addresses_on_street_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id", using: :btree

  create_table "opening_hours", force: true do |t|
    t.time     "from"
    t.time     "to"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opening_hours", ["place_id"], name: "index_opening_hours_on_place_id", using: :btree

  create_table "opening_hours_week_days", force: true do |t|
    t.integer "opening_hour_id"
    t.integer "week_day_id"
  end

  add_index "opening_hours_week_days", ["opening_hour_id", "week_day_id"], name: "opening_hour_week_day_index", unique: true, using: :btree

  create_table "places", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "streets", force: true do |t|
    t.string   "name"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "streets", ["district_id"], name: "index_streets_on_district_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "login"
    t.string   "password"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "date_of_birth"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "week_days", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
