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

ActiveRecord::Schema.define(version: 20180212164603) do

  create_table "lecture_module_contents", force: :cascade do |t|
    t.string "code"
    t.integer "academic_year_end"
    t.integer "week"
    t.string "data_source"
    t.text "description"
    t.integer "lecture_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_module_id"], name: "index_lecture_module_contents_on_lecture_module_id"
  end

  create_table "lecture_modules", force: :cascade do |t|
    t.string "code"
    t.integer "academic_year_end"
    t.integer "semester"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "academic_year_end"], name: "index_lecture_modules_on_code_and_academic_year_end", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
