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

ActiveRecord::Schema.define(version: 20140807010744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: true do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "environment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_files", force: true do |t|
    t.integer  "app_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "config_files", ["app_id"], name: "index_config_files_on_app_id", using: :btree

  create_table "config_vars", force: true do |t|
    t.integer  "config_file_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "config_vars", ["config_file_id", "key"], name: "index_config_vars_on_config_file_id_and_key", unique: true, using: :btree
  add_index "config_vars", ["config_file_id"], name: "index_config_vars_on_config_file_id", using: :btree

end
