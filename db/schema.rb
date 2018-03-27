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

ActiveRecord::Schema.define(version: 20180327184752) do

  create_table "lecture_module_contents", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content_file_name"
    t.string "content_content_type"
    t.integer "content_file_size"
    t.datetime "content_updated_at"
    t.string "youTube_link"
    t.integer "week_id"
    t.index ["week_id"], name: "index_lecture_module_contents_on_week_id"
  end

  create_table "lecture_modules", force: :cascade do |t|
    t.string "code"
    t.integer "academic_year_end"
    t.integer "semester"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["code", "academic_year_end"], name: "index_lecture_modules_on_code_and_academic_year_end", unique: true
    t.index ["user_id"], name: "index_lecture_modules_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "week_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
    t.index ["week_id"], name: "index_notes_on_week_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sort_tasks_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subtasks", force: :cascade do |t|
    t.integer "task_id"
    t.string "title"
    t.date "due_date"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_subtasks_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "todo_list_id"
    t.string "title"
    t.date "due_date"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["todo_list_id"], name: "index_tasks_on_todo_list_id"
  end

  create_table "timers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "study_length"
    t.integer "short_break_length"
    t.integer "long_break_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_timers_on_user_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "user_module_linkers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lecture_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_module_id"], name: "index_user_module_linkers_on_lecture_module_id"
    t.index ["user_id"], name: "index_user_module_linkers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.integer "lecture_module_id"
    t.integer "week_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_module_id"], name: "index_weeks_on_lecture_module_id"
  end

end
