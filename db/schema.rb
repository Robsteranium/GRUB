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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110411210556) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["id"], :name => "index_assignments_on_id"
  add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "boxes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "box_id"
    t.integer  "subscription_id"
    t.boolean  "delivered"
    t.string   "delivery_result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "payment_collected"
  end

  create_table "locations", :force => true do |t|
    t.float    "lng"
    t.float    "lat"
    t.string   "name"
    t.string   "postcode"
    t.string   "street"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["id"], :name => "index_roles_on_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "box_id"
    t.integer  "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weekday"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.float    "amount"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delivery_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "delivery_notes"
    t.string   "address"
    t.string   "postcode"
    t.string   "phone"
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
