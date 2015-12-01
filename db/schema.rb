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

ActiveRecord::Schema.define(version: 20150328163807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_id"
    t.datetime "published_at"
    t.datetime "trashed_at"
  end

  create_table "drafts", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "previous_draft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drafts", ["created_at"], name: "index_drafts_on_created_at", using: :btree
  add_index "drafts", ["event"], name: "index_drafts_on_event", using: :btree
  add_index "drafts", ["item_id"], name: "index_drafts_on_item_id", using: :btree
  add_index "drafts", ["item_type"], name: "index_drafts_on_item_type", using: :btree
  add_index "drafts", ["updated_at"], name: "index_drafts_on_updated_at", using: :btree
  add_index "drafts", ["whodunnit"], name: "index_drafts_on_whodunnit", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_id"
  end

  add_index "galleries", ["blog_id"], name: "index_galleries_on_blog_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gallery_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "images", ["gallery_id"], name: "index_images_on_gallery_id", using: :btree

end
