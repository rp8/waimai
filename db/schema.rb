# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "customers", :force => true do |t|
    t.string   "first_name", :limit => 50
    t.string   "last_name",  :limit => 50
    t.string   "phone",      :limit => 15,  :null => false
    t.string   "address",    :limit => 100, :null => false
    t.string   "note",       :limit => 100
    t.integer  "site_id",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["phone", "site_id"], :name => "index_customers_on_site_id_and_phone"

  create_table "memberships", :force => true do |t|
    t.integer  "site_id",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["site_id", "user_id"], :name => "index_user_roles_on_site_id_and_user_id", :unique => true

  create_table "orders", :force => true do |t|
    t.integer  "site_id",                    :null => false
    t.integer  "customer_id",                :null => false
    t.integer  "order_id",                   :null => false
    t.string   "status",                     :null => false
    t.string   "note",        :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["customer_id", "order_id", "site_id"], :name => "index_orders_on_site_id_and_customer_id_and_order_id"

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.string   "desc",       :limit => 500
    t.string   "web",        :limit => 100
    t.string   "email",      :limit => 100
    t.string   "phone",      :limit => 15,  :null => false
    t.string   "fax",        :limit => 15
    t.string   "street",     :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",    :limit => 50
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
