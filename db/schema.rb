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

ActiveRecord::Schema[7.0].define(version: 2023_12_13_145059) do
  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brake_times", charset: "utf8", force: :cascade do |t|
    t.integer "min_work_duration"
    t.integer "max_work_duration"
    t.integer "break_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "casts", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "family_name", null: false
    t.integer "company_id", null: false
    t.integer "health", default: 100, null: false
    t.integer "sara_shiwake_skill_id", default: 1, null: false
    t.integer "sara_arai_skill_id", default: 1, null: false
    t.integer "sara_nagashi_skill_id", default: 1, null: false
    t.integer "sara_huki_skill_id", default: 1, null: false
    t.integer "kigu_arai_skill_id", default: 1, null: false
    t.integer "kigu_nagashi_skill_id", default: 1, null: false
    t.integer "kigu_huki_skill_id", default: 1, null: false
    t.integer "silver_migaki_skill_id", default: 1, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_casts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_casts_on_reset_password_token", unique: true
  end

  create_table "positions", charset: "utf8", force: :cascade do |t|
    t.string "position_name", null: false
    t.integer "capacity", null: false
    t.integer "fatigue_level", null: false
    t.integer "position_type", null: false
    t.integer "required_skill_level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", charset: "utf8", force: :cascade do |t|
    t.bigint "cast_id", null: false
    t.bigint "position_id", null: false
    t.bigint "workday_id", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_schedules_on_cast_id"
    t.index ["position_id"], name: "index_schedules_on_position_id"
    t.index ["workday_id"], name: "index_schedules_on_workday_id"
  end

  create_table "workdays", charset: "utf8", force: :cascade do |t|
    t.bigint "cast_id", null: false
    t.date "date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_workdays_on_cast_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "schedules", "casts"
  add_foreign_key "schedules", "positions"
  add_foreign_key "workdays", "casts"
end
