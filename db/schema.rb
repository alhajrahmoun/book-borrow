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

ActiveRecord::Schema.define(version: 20161021163603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.integer  "book_id"
    t.string   "name"
    t.string   "author"
    t.string   "translator"
    t.integer  "num_of_pages"
    t.string   "page_size"
    t.string   "publishing_house"
    t.string   "group"
    t.boolean  "approved"
    t.boolean  "returned_back"
    t.date     "borrow_date"
    t.boolean  "available"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "subscriber_id"
    t.integer  "owner_id"
    t.string   "owner_name"
    t.integer  "borrow_times"
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
    t.index ["owner_id"], name: "index_books_on_owner_id", using: :btree
    t.index ["sub_category_id"], name: "index_books_on_sub_category_id", using: :btree
    t.index ["subscriber_id"], name: "index_books_on_subscriber_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "rating"
    t.float    "average"
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_sub_categories_on_category_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birthday"
    t.string   "education_level"
    t.string   "specialization"
    t.string   "mobile"
    t.string   "current_address"
    t.string   "favorite_language"
    t.string   "favorite_book_type"
    t.string   "friend_name"
    t.integer  "points"
    t.integer  "borrow_times"
    t.string   "borrow_group"
    t.boolean  "approved"
    t.text     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "fcm_token"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books", "sub_categories"
  add_foreign_key "books", "users", column: "owner_id"
  add_foreign_key "books", "users", column: "subscriber_id"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "sub_categories", "categories"
end
