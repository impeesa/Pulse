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

ActiveRecord::Schema.define(:version => 20110607123340) do

  create_table "admins", :force => true do |t|
    t.string "site_name"
    t.string "footer_text"
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
    t.integer  "width"
    t.integer  "height"
  end

  create_table "comments", :force => true do |t|
    t.string   "weekid"
    t.string   "contactname"
    t.float    "score"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "accountname"
  end

  create_table "group_tabs", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "tab_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_trackings", :force => true do |t|
    t.string   "email"
    t.datetime "sign_in_at"
  end

  create_table "nps", :force => true do |t|
    t.integer  "nps_id"
    t.string   "week_id"
    t.string   "accountname"
    t.string   "contactname"
    t.float    "score"
    t.text     "comments"
    t.datetime "submitdate"
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

  create_table "scores", :force => true do |t|
    t.string   "week_id"
    t.float    "nps"
    t.integer  "score"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tabs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tbl_Output_SPOS", :force => true do |t|
    t.float   "Region"
    t.string  "Report_name"
    t.string  "Myers_BranchID"
    t.integer "Sales_ID"
    t.string  "Sales_Name"
    t.integer "Customer_No"
    t.string  "Customer_Name"
    t.float   "CYTD_Qty_A"
    t.float   "CYTD_Qty_B"
    t.float   "CYTD_Qty_C"
    t.float   "CYTD_Qty_D"
    t.float   "CYTD_Qty_E"
    t.float   "CYTD_Qty_F"
    t.float   "CYTD_Qty_Total"
    t.float   "PYTD_Qty_A"
    t.float   "PYTD_Qty_B"
    t.float   "PYTD_Qty_C"
    t.float   "PYTD_Qty_D"
    t.float   "PYTD_Qty_E"
    t.float   "PYTD_Qty_F"
    t.float   "PYTD_Qty_Total"
    t.float   "Var_Qty_A"
    t.float   "Var_Qty_B"
    t.float   "Var_Qty_C"
    t.float   "Var_Qty_D"
    t.float   "Var_Qty_E"
    t.float   "Var_Qty_F"
    t.float   "Var_Qty_Total"
    t.float   "WeekNum_ID"
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
    t.boolean  "is_admin",         :default => false
    t.string   "hashed_password"
    t.string   "salt"
  end

end
