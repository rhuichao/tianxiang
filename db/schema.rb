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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140623052649) do

  create_table "attendances", :force => true do |t|
    t.datetime "date"
    t.float    "work_time"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "bonus", :force => true do |t|
    t.datetime "date"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.integer  "id_card"
    t.string   "name"
    t.datetime "join_date"
    t.datetime "resign_date"
    t.datetime "birth_date"
    t.integer  "mobile"
    t.integer  "telephone"
    t.integer  "fax"
    t.string   "address"
    t.integer  "work_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "salaries", :force => true do |t|
    t.datetime "date"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "total"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "withdraws", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.integer  "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "work_days", :force => true do |t|
    t.datetime "date"
    t.float    "total"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "work_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
