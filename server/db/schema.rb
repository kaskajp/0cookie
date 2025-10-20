# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_20_212200) do
  create_table "banner_themes", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.json "variables"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_banner_themes_on_workspace_id"
  end

  create_table "consent_records", force: :cascade do |t|
    t.integer "website_id", null: false
    t.string "session_id_hash", null: false
    t.text "purposes"
    t.string "region"
    t.string "policy_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id", "session_id_hash"], name: "index_consent_records_on_website_id_and_session_id_hash"
    t.index ["website_id"], name: "index_consent_records_on_website_id"
  end

  create_table "cookie_findings", force: :cascade do |t|
    t.integer "scan_id", null: false
    t.string "name"
    t.string "domain"
    t.string "path"
    t.string "expiry"
    t.string "category_suggested"
    t.integer "confidence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scan_id"], name: "index_cookie_findings_on_scan_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "workspace_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_memberships_on_user_id"
    t.index ["workspace_id"], name: "index_memberships_on_workspace_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.json "entitlements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "scans", force: :cascade do |t|
    t.integer "website_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text "results_summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_scans_on_website_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.integer "plan_id", null: false
    t.string "status"
    t.datetime "period_start"
    t.datetime "period_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["workspace_id"], name: "index_subscriptions_on_workspace_id"
  end

  create_table "usage_meters", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.string "metric", null: false
    t.date "period_start", null: false
    t.date "period_end", null: false
    t.integer "used", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id", "metric", "period_start", "period_end"], name: "index_usage_unique_period", unique: true
    t.index ["workspace_id"], name: "index_usage_meters_on_workspace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "mfa_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.string "url"
    t.string "scan_schedule"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_websites_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.json "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "banner_themes", "workspaces"
  add_foreign_key "consent_records", "websites"
  add_foreign_key "cookie_findings", "scans"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships", "workspaces"
  add_foreign_key "scans", "websites"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "workspaces"
  add_foreign_key "usage_meters", "workspaces"
  add_foreign_key "websites", "workspaces"
end
