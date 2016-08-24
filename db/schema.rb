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

ActiveRecord::Schema.define(version: 20160824212110) do

  create_table "apps", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "uuid",                  limit: 255
    t.string   "environment",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aws_access_key_id",     limit: 255
    t.string   "aws_secret_access_key", limit: 255
    t.string   "aws_bucket",            limit: 255
    t.string   "s3_path_prefix",        limit: 255
    t.boolean  "sync_to_s3",                        default: false, null: false
  end

  create_table "config_files", force: :cascade do |t|
    t.integer  "app_id",                       limit: 4
    t.string   "name",                         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "omit_environment_from_output",             default: false
  end

  add_index "config_files", ["app_id"], name: "index_config_files_on_app_id", using: :btree

  create_table "config_vars", force: :cascade do |t|
    t.integer  "config_file_id", limit: 4
    t.string   "key",            limit: 255
    t.string   "value",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "config_vars", ["config_file_id", "key"], name: "index_config_vars_on_config_file_id_and_key", unique: true, using: :btree
  add_index "config_vars", ["config_file_id"], name: "index_config_vars_on_config_file_id", using: :btree

end
