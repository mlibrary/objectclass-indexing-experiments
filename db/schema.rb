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

ActiveRecord::Schema.define(version: 2019_08_01_171352) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_type"
    t.string "document_id"
    t.string "document_type"
    t.binary "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_bookmarks_on_document_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "coll_records", force: :cascade do |t|
    t.string "identifier"
    t.string "creator"
    t.string "subject"
    t.string "title"
    t.string "dc_format"
    t.string "coverage"
    t.date "date"
    t.string "source"
    t.string "rights"
    t.string "dc_type"
    t.text "description"
    t.string "genre"
    t.text "member_of"
    t.string "bhl_cr"
    t.string "bhl_el"
    t.string "bhl_g"
    t.string "bhl_su"
    t.string "bhl_it"
    t.string "crania1ic_collection"
    t.string "crania1ic_includes"
    t.string "crania1ic_pathology_symptom"
    t.string "crania1ic_sex"
    t.string "hart_cr"
    t.string "hart_da"
    t.string "hart_lo"
    t.integer "hart_ordno"
    t.string "hart_su"
    t.string "hart_vt"
    t.integer "hart_wono"
    t.string "kelsey_colls"
    t.string "kelsey_lot"
    t.string "kelsey_mat"
    t.string "kelsey_objtype"
    t.string "kelsey_sit"
    t.string "kelsey_verbpro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.binary "query_params"
    t.integer "user_id"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
