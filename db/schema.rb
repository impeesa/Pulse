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

ActiveRecord::Schema.define(:version => 20101217010712) do

  create_table "account_details", :force => true do |t|
    t.integer "branch"
    t.integer "sp_number"
    t.string  "sp_name"
    t.integer "account_number"
    t.string  "account_name"
    t.float   "cytd_a"
    t.float   "cytd_b"
    t.float   "cytd_c"
    t.float   "cytd_d"
    t.float   "cytd_e"
    t.float   "cytd_f"
    t.float   "cytd_total"
    t.float   "pytd_a"
    t.float   "pytd_b"
    t.float   "pytd_c"
    t.float   "pytd_d"
    t.float   "pytd_e"
    t.float   "pytd_f"
    t.float   "pytd_total"
    t.float   "ytd_variance_a"
    t.float   "ytd_variance_b"
    t.float   "ytd_variance_c"
    t.float   "ytd_variance_d"
    t.float   "ytd_variance_e"
    t.float   "ytd_variance_f"
    t.float   "ytd_variance_total"
  end

  create_table "authentications", :force => true do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
  end

  create_table "chart_groups", :force => true do |t|
    t.integer "chart_id"
    t.integer "group_id"
  end

  create_table "charts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "D_ID"
    t.string   "Section"
    t.string   "Item"
    t.string   "Class"
    t.string   "Term"
    t.date     "Period"
    t.float    "Value"
    t.string   "Type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.boolean  "allowed_to_login", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
