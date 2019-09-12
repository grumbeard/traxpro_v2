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

ActiveRecord::Schema.define(version: 2019_09_08_110035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.bigint "sub_category_id"
    t.bigint "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_categorizations_on_issue_id"
    t.index ["sub_category_id"], name: "index_categorizations_on_sub_category_id"
  end

  create_table "issue_solvers", force: :cascade do |t|
    t.bigint "issue_id"
    t.bigint "project_solver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_solvers_on_issue_id"
    t.index ["project_solver_id"], name: "index_issue_solvers_on_project_solver_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "map_id"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.boolean "resolved", default: false
    t.boolean "accepted", default: false
    t.string "title"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline"
    t.datetime "date_resolved"
    t.datetime "date_accepted"
    t.datetime "date_created"
    t.index ["map_id"], name: "index_issues_on_map_id"
    t.index ["project_id"], name: "index_issues_on_project_id"
  end

  create_table "maps", force: :cascade do |t|
    t.bigint "project_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["project_id"], name: "index_maps_on_project_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.string "photo"
    t.bigint "issue_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_messages_on_issue_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "project_solvers", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_solvers_on_project_id"
    t.index ["user_id"], name: "index_project_solvers_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.bigint "sub_category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_category_id"], name: "index_specializations_on_sub_category_id"
    t.index ["user_id"], name: "index_specializations_on_user_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "solver", default: false
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categorizations", "issues"
  add_foreign_key "categorizations", "sub_categories"
  add_foreign_key "issue_solvers", "issues"
  add_foreign_key "issue_solvers", "project_solvers"
  add_foreign_key "issues", "maps"
  add_foreign_key "issues", "projects"
  add_foreign_key "maps", "projects"
  add_foreign_key "messages", "issues"
  add_foreign_key "messages", "users"
  add_foreign_key "project_solvers", "projects"
  add_foreign_key "project_solvers", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "specializations", "sub_categories"
  add_foreign_key "specializations", "users"
  add_foreign_key "sub_categories", "categories"
end
