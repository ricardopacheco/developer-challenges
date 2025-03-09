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

ActiveRecord::Schema[8.0].define(version: 2025_03_07_204534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.string "short", null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visit_links_count", default: 0, null: false
    t.index ["short", "expires_at"], name: "index_links_on_short_and_expires_at", where: "(expires_at IS NOT NULL)"
    t.index ["short"], name: "index_links_on_short", unique: true
    t.check_constraint "length(short::text) >= 5 AND length(short::text) <= 10", name: "short_length_check"
    t.check_constraint "length(url::text) >= 4 AND length(url::text) <= 2000", name: "url_length_check"
  end

  create_table "visit_links", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.jsonb "metadata", default: {}
    t.datetime "created_at"
    t.index ["link_id"], name: "index_visit_links_on_link_id"
  end

  add_foreign_key "visit_links", "links"
end
