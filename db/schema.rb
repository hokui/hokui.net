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

ActiveRecord::Schema.define(version: 20150527114549) do

  create_table "access_tokens", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.string   "token",            null: false
    t.datetime "last_activity_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["token"], name: "index_access_tokens_on_token", unique: true

  create_table "class_years", force: :cascade do |t|
    t.integer  "year",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ml_list_id"
  end

  add_index "class_years", ["year"], name: "index_class_years_on_year", unique: true

  create_table "document_files", force: :cascade do |t|
    t.integer  "document_id",                          null: false
    t.integer  "user_id",                              null: false
    t.string   "file_name",                            null: false
    t.string   "file_content_type",                    null: false
    t.string   "file_md5",                             null: false
    t.string   "comments"
    t.integer  "download_count",           default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "previous_user_name"
    t.integer  "previous_user_class_year"
  end

  add_index "document_files", ["document_id"], name: "index_document_files_on_document_id"
  add_index "document_files", ["file_md5"], name: "index_document_files_on_file_md5", unique: true
  add_index "document_files", ["user_id"], name: "index_document_files_on_user_id"

  create_table "documents", force: :cascade do |t|
    t.integer  "subject_id", null: false
    t.integer  "class_year", null: false
    t.integer  "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "documents", ["class_year"], name: "index_documents_on_class_year"
  add_index "documents", ["code"], name: "index_documents_on_code"
  add_index "documents", ["subject_id", "class_year", "code"], name: "index_documents_on_subject_id_and_class_year_and_code", unique: true
  add_index "documents", ["subject_id"], name: "index_documents_on_subject_id"

  create_table "download_tokens", force: :cascade do |t|
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "download_tokens", ["token"], name: "index_download_tokens_on_token", unique: true

  create_table "news", force: :cascade do |t|
    t.string   "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "semesters", force: :cascade do |t|
    t.integer  "class_year_id", null: false
    t.string   "identifier",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "semesters", ["class_year_id", "identifier"], name: "index_semesters_on_class_year_id_and_identifier", unique: true
  add_index "semesters", ["class_year_id"], name: "index_semesters_on_class_year_id"

  create_table "semesters_subjects", id: false, force: :cascade do |t|
    t.integer "semester_id", null: false
    t.integer "subject_id",  null: false
  end

  add_index "semesters_subjects", ["semester_id", "subject_id"], name: "index_semesters_subjects_on_semester_id_and_subject_id", unique: true

  create_table "subjects", force: :cascade do |t|
    t.string   "title_ja",   null: false
    t.string   "title_en",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["title_en"], name: "index_subjects_on_title_en", unique: true
  add_index "subjects", ["title_ja"], name: "index_subjects_on_title_ja", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password",                                null: false
    t.string   "salt",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "approval_state"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "family_name",                     default: "",    null: false
    t.string   "given_name",                      default: "",    null: false
    t.string   "handle_name",                     default: "",    null: false
    t.date     "birthday",                                        null: false
    t.string   "email_mobile"
    t.boolean  "admin",                           default: false, null: false
    t.integer  "class_year_id",                   default: 1,     null: false
    t.integer  "ml_member_id"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token"
  add_index "users", ["class_year_id"], name: "index_users_on_class_year_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["handle_name"], name: "index_users_on_handle_name", unique: true
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
