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

ActiveRecord::Schema.define(version: 0) do

  create_table "article_tags", id: false, force: :cascade do |t|
    t.integer "article_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "article_tags", ["article_id"], name: "article_tags_ibfk_1", using: :btree
  add_index "article_tags", ["tag_id"], name: "tag_id", using: :btree

  create_table "articles", primary_key: "article_id", force: :cascade do |t|
    t.integer "person_id",  limit: 4,     null: false
    t.integer "graphic_id", limit: 4,     null: false
    t.integer "issue_id",   limit: 4,     null: false
    t.string  "headline",   limit: 200
    t.text    "text",       limit: 65535, null: false
    t.binary  "brief",      limit: 1
  end

  add_index "articles", ["graphic_id"], name: "graphic_id", using: :btree
  add_index "articles", ["issue_id"], name: "issue_id", using: :btree
  add_index "articles", ["person_id"], name: "person_id", using: :btree

  create_table "ed_pcp_tags", id: false, force: :cascade do |t|
    t.integer "ed_pcp_id", limit: 4, null: false
    t.integer "tag_id",    limit: 4, null: false
  end

  add_index "ed_pcp_tags", ["ed_pcp_id"], name: "ed_pcp_id", using: :btree
  add_index "ed_pcp_tags", ["tag_id"], name: "tag_id", using: :btree

  create_table "ed_pcps", primary_key: "ed_pcp_id", force: :cascade do |t|
    t.integer "issue_id",        limit: 4,          null: false
    t.binary  "ed",              limit: 1
    t.binary  "point",           limit: 1
    t.binary  "counterpoint",    limit: 1
    t.integer "crspnd_point_id", limit: 4
    t.string  "headline",        limit: 200
    t.string  "author",          limit: 200
    t.string  "author_title",    limit: 200
    t.binary  "author_image",    limit: 4294967295
    t.text    "text",            limit: 65535
  end

  add_index "ed_pcps", ["issue_id"], name: "issue_id", using: :btree

  create_table "feature_tags", id: false, force: :cascade do |t|
    t.integer "feature_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "feature_tags", ["feature_id"], name: "feature_id", using: :btree
  add_index "feature_tags", ["tag_id"], name: "tag_id", using: :btree

  create_table "features", primary_key: "feature_id", force: :cascade do |t|
    t.integer "issue_id", limit: 4,          null: false
    t.string  "title",    limit: 200
    t.binary  "image",    limit: 4294967295
    t.binary  "spread",   limit: 1
  end

  add_index "features", ["issue_id"], name: "issue_id", using: :btree

  create_table "graphics", primary_key: "graphic_id", force: :cascade do |t|
    t.integer "article_id", limit: 4
    t.integer "person_id",  limit: 4,   null: false
    t.integer "issue_id",   limit: 4,   null: false
    t.string  "image",      limit: 200
    t.string  "caption",    limit: 200
  end

  add_index "graphics", ["article_id"], name: "article_id", using: :btree
  add_index "graphics", ["issue_id"], name: "issue_id", using: :btree
  add_index "graphics", ["person_id"], name: "person_id", using: :btree

  create_table "issues", primary_key: "issue_id", force: :cascade do |t|
    t.integer "volume_no",           limit: 4
    t.integer "issue_no",            limit: 4
    t.date    "date"
    t.string  "staff_photo",         limit: 200
    t.string  "staff_photo_caption", limit: 200
    t.text    "eic_note",            limit: 65535
    t.text    "booster_club",        limit: 65535
    t.string  "brief_title",         limit: 200
    t.string  "masthead",            limit: 200
    t.string  "celeb_quote",         limit: 200
    t.string  "celeb",               limit: 200
    t.binary  "celeb_photo",         limit: 4294967295
  end

  create_table "persons", primary_key: "person_id", force: :cascade do |t|
    t.integer "position_id", limit: 4,          null: false
    t.string  "name",        limit: 200
    t.text    "bio",         limit: 65535
    t.binary  "image",       limit: 4294967295
    t.binary  "current",     limit: 1
  end

  add_index "persons", ["position_id"], name: "position_id", using: :btree

  create_table "positions", primary_key: "position_id", force: :cascade do |t|
    t.string "title", limit: 200
  end

  create_table "self_ads", primary_key: "self_ad_id", force: :cascade do |t|
    t.integer "issue_id", limit: 4,          null: false
    t.string  "text",     limit: 200
    t.binary  "image",    limit: 4294967295
  end

  add_index "self_ads", ["issue_id"], name: "issue_id", using: :btree

  create_table "skyboxes", primary_key: "skybox_id", force: :cascade do |t|
    t.integer "issue_id", limit: 4,          null: false
    t.string  "text1",    limit: 200
    t.string  "text2",    limit: 200
    t.binary  "image",    limit: 4294967295
  end

  add_index "skyboxes", ["issue_id"], name: "issue_id", using: :btree

  create_table "tags", primary_key: "tag_id", force: :cascade do |t|
    t.string "title", limit: 200
  end

  create_table "top_ten_entries", primary_key: "top_ten_entry_id", force: :cascade do |t|
    t.integer "top_ten_id", limit: 4,   null: false
    t.string  "text",       limit: 200, null: false
    t.integer "entry_no",   limit: 4,   null: false
  end

  add_index "top_ten_entries", ["top_ten_id"], name: "top_ten_id", using: :btree

  create_table "top_ten_tags", id: false, force: :cascade do |t|
    t.integer "top_ten_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "top_ten_tags", ["tag_id"], name: "tag_id", using: :btree
  add_index "top_ten_tags", ["top_ten_id"], name: "top_ten_id", using: :btree

  create_table "top_tens", primary_key: "top_ten_id", force: :cascade do |t|
    t.integer "issue_id",      limit: 4,   null: false
    t.string  "title",         limit: 200, null: false
    t.integer "no_of_entries", limit: 4,   null: false
  end

  add_index "top_tens", ["issue_id"], name: "issue_id", using: :btree

  add_foreign_key "article_tags", "articles", primary_key: "article_id", name: "article_tags_ibfk_1"
  add_foreign_key "article_tags", "tags", primary_key: "tag_id", name: "article_tags_ibfk_2"
  add_foreign_key "articles", "graphics", primary_key: "graphic_id", name: "articles_ibfk_3"
  add_foreign_key "articles", "issues", primary_key: "issue_id", name: "articles_ibfk_2"
  add_foreign_key "articles", "persons", primary_key: "person_id", name: "articles_ibfk_1"
  add_foreign_key "ed_pcp_tags", "ed_pcps", primary_key: "ed_pcp_id", name: "ed_pcp_tags_ibfk_1"
  add_foreign_key "ed_pcp_tags", "tags", primary_key: "tag_id", name: "ed_pcp_tags_ibfk_2"
  add_foreign_key "ed_pcps", "issues", primary_key: "issue_id", name: "ed_pcps_ibfk_1"
  add_foreign_key "feature_tags", "features", primary_key: "feature_id", name: "feature_tags_ibfk_1"
  add_foreign_key "feature_tags", "tags", primary_key: "tag_id", name: "feature_tags_ibfk_2"
  add_foreign_key "features", "issues", primary_key: "issue_id", name: "features_ibfk_1"
  add_foreign_key "graphics", "articles", primary_key: "article_id", name: "graphics_ibfk_1"
  add_foreign_key "graphics", "issues", primary_key: "issue_id", name: "graphics_ibfk_3"
  add_foreign_key "graphics", "persons", primary_key: "person_id", name: "graphics_ibfk_2"
  add_foreign_key "persons", "positions", primary_key: "position_id", name: "persons_ibfk_1"
  add_foreign_key "self_ads", "issues", primary_key: "issue_id", name: "self_ads_ibfk_1"
  add_foreign_key "skyboxes", "issues", primary_key: "issue_id", name: "skyboxes_ibfk_1"
  add_foreign_key "top_ten_entries", "top_tens", primary_key: "top_ten_id", name: "top_ten_entries_ibfk_1"
  add_foreign_key "top_ten_tags", "tags", primary_key: "tag_id", name: "top_ten_tags_ibfk_2"
  add_foreign_key "top_ten_tags", "top_tens", primary_key: "top_ten_id", name: "top_ten_tags_ibfk_1"
  add_foreign_key "top_tens", "issues", primary_key: "issue_id", name: "top_tens_ibfk_1"
end
