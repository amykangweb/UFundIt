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

ActiveRecord::Schema.define(version: 20150921221412) do

  create_table "commitments", force: :cascade do |t|
    t.integer  "payment"
    t.integer  "deal_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "commitments", ["deal_id"], name: "index_commitments_on_deal_id"
  add_index "commitments", ["user_id"], name: "index_commitments_on_user_id"

  create_table "deals", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.integer  "goal"
    t.string   "location"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "published",   default: false
    t.boolean  "private",     default: false
    t.integer  "amount"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "owner_id"
  end

  add_index "deals", ["owner_id"], name: "index_deals_on_owner_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
