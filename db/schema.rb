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

ActiveRecord::Schema.define(version: 20150320123525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "git_id"
    t.json     "raw"
    t.string   "git_type"
    t.string   "git_actor"
    t.string   "git_actor_id"
    t.string   "git_repo"
    t.string   "git_repo_id"
    t.datetime "event_at"
  end

  create_table "members", force: true do |t|
    t.integer  "team_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "github_login"
    t.boolean  "deactivated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url"
    t.string   "github_id"
    t.string   "alias_list"
  end

  create_table "orgs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.string   "request"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "response"
    t.string   "caller"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "org_id"
  end

end
