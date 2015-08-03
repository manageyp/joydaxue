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

ActiveRecord::Schema.define(version: 20150730100115) do

  create_table "captchas", force: true do |t|
    t.string   "captcha_type",             null: false
    t.string   "cellphone",                null: false
    t.integer  "send_count",   default: 0
    t.string   "code",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "captchas", ["captcha_type", "cellphone"], name: "index_captchas_on_captcha_type_and_cellphone", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.integer  "province_id", null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id",     null: false
    t.string   "detail_type", null: false
    t.integer  "detail_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["detail_type", "detail_id"], name: "index_favorites_on_detail_type_and_detail_id", unique: true, using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "to_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["user_id", "to_user_id"], name: "index_follows_on_user_id_and_to_user_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id",               null: false
    t.integer  "receiver_id",             null: false
    t.string   "detail_type",             null: false
    t.integer  "detail_id",               null: false
    t.string   "description"
    t.integer  "status",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["detail_type"], name: "index_messages_on_detail_type", using: :btree
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "role_id",         null: false
    t.string   "controller_name"
    t.string   "action_names"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["role_id", "controller_name"], name: "index_permissions_on_role_id_and_controller_name", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qqwry_ips", force: true do |t|
    t.string   "start_long"
    t.string   "end_long"
    t.string   "country"
    t.string   "location"
    t.string   "start_ip"
    t.string   "end_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qqwry_ips", ["end_long"], name: "index_qqwry_ips_on_end_long", using: :btree
  add_index "qqwry_ips", ["start_long"], name: "index_qqwry_ips_on_start_long", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_introductions", force: true do |t|
    t.integer  "school_id",     null: false
    t.string   "short_content"
    t.text     "full_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "school_introductions", ["school_id"], name: "index_school_introductions_on_school_id", using: :btree

  create_table "school_photos", force: true do |t|
    t.integer  "school_id",              null: false
    t.string   "image"
    t.integer  "position",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "school_photos", ["school_id"], name: "index_school_photos_on_school_id", using: :btree

  create_table "schools", force: true do |t|
    t.integer  "province_id",                                               null: false
    t.integer  "city_id",                                                   null: false
    t.string   "name",                                                      null: false
    t.string   "address"
    t.string   "college_type"
    t.string   "telephone"
    t.string   "avatar"
    t.string   "website"
    t.string   "found_year"
    t.string   "zipcode"
    t.string   "affiliate"
    t.decimal  "latitude",         precision: 10, scale: 6, default: 0.0
    t.decimal  "longitude",        precision: 10, scale: 6, default: 0.0
    t.boolean  "is_211",                                    default: false
    t.boolean  "is_985",                                    default: false
    t.boolean  "is_edu_affiliate",                          default: false
    t.boolean  "has_bachelor",                              default: false
    t.boolean  "is_independent",                            default: false
    t.boolean  "is_civilian_run",                           default: false
    t.integer  "key_disciplines",                           default: 0
    t.integer  "master_num",                                default: 0
    t.integer  "phd_num",                                   default: 0
    t.integer  "academician_num",                           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["address"], name: "index_schools_on_address", using: :btree
  add_index "schools", ["city_id"], name: "index_schools_on_city_id", using: :btree
  add_index "schools", ["college_type"], name: "index_schools_on_college_type", using: :btree
  add_index "schools", ["has_bachelor"], name: "index_schools_on_has_bachelor", using: :btree
  add_index "schools", ["is_211"], name: "index_schools_on_is_211", using: :btree
  add_index "schools", ["is_985"], name: "index_schools_on_is_985", using: :btree
  add_index "schools", ["is_edu_affiliate"], name: "index_schools_on_is_edu_affiliate", using: :btree
  add_index "schools", ["name"], name: "index_schools_on_name", using: :btree
  add_index "schools", ["province_id"], name: "index_schools_on_province_id", using: :btree

  create_table "user_devices", force: true do |t|
    t.integer  "user_id",                  null: false
    t.string   "device_type"
    t.string   "device_id",                null: false
    t.string   "device_token"
    t.integer  "status",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_devices", ["device_id"], name: "index_user_devices_on_device_id", using: :btree
  add_index "user_devices", ["device_token"], name: "index_user_devices_on_device_token", using: :btree
  add_index "user_devices", ["user_id"], name: "index_user_devices_on_user_id", using: :btree

  create_table "user_logins", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "login_type"
    t.string   "login_ip"
    t.string   "location"
    t.datetime "login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_logins", ["login_ip"], name: "index_user_logins_on_login_ip", using: :btree
  add_index "user_logins", ["user_id"], name: "index_user_logins_on_user_id", using: :btree

  create_table "user_roles", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "user_tokens", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tokens", ["token"], name: "index_user_tokens_on_token", unique: true, using: :btree
  add_index "user_tokens", ["user_id"], name: "index_user_tokens_on_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                      null: false
    t.string   "email"
    t.string   "cellphone"
    t.integer  "sex"
    t.integer  "follows_count", default: 0
    t.integer  "fans_count",    default: 0
    t.integer  "status",        default: 0
    t.string   "memo"
    t.string   "password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cellphone"], name: "index_users_on_cellphone", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
