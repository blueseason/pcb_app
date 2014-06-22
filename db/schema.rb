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

ActiveRecord::Schema.define(version: 20140525083814) do

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.decimal  "length"
    t.decimal  "width"
    t.integer  "layer"
    t.integer  "amount",                      default: 0
    t.integer  "pinban_style_num",            default: 1
    t.integer  "type"
    t.decimal  "thickness"
    t.integer  "zuhan_color"
    t.integer  "zifu_color"
    t.integer  "hanpan_pengdu"
    t.integer  "zuhan_cover"
    t.integer  "test"
    t.integer  "tongbo_thickness"
    t.integer  "produce_time"
    t.integer  "need_receipt"
    t.integer  "if_in_province"
    t.integer  "express"
    t.string   "express_no"
    t.decimal  "price",                       default: 0.0
    t.string   "pcb_file_path"
    t.string   "comment"
    t.integer  "pay_type",                    default: 0
    t.string   "pay_id",           limit: 16
    t.integer  "pay_status"
    t.integer  "status",                      default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "real_name"
    t.string   "qq"
    t.string   "company_name"
    t.string   "phone"
    t.string   "fax"
    t.string   "address"
    t.integer  "province"
    t.integer  "city"
    t.datetime "last_login_time"
    t.integer  "login_count",     default: 0
    t.integer  "level",           default: 0
    t.integer  "points",          default: 0
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["qq", "mobile"], name: "index_users_on_qq_and_mobile", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
