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

ActiveRecord::Schema[7.0].define(version: 2023_10_04_021304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
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

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "auctions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start"
    t.datetime "finish"
    t.string "condiciones"
    t.string "link_auction"
    t.index ["user_id"], name: "index_auctions_on_user_id"
  end

  create_table "bids", force: :cascade do |t|
    t.integer "amount"
    t.boolean "winning"
    t.bigint "user_id", null: false
    t.bigint "auction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_bids_on_auction_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archive", default: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "auction_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "horse_id"
    t.index ["auction_id"], name: "index_favorites_on_auction_id"
    t.index ["horse_id"], name: "index_favorites_on_horse_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "helps", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved", default: false
    t.index ["user_id"], name: "index_helps_on_user_id"
  end

  create_table "horses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "pedigree"
    t.date "birthday"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rider"
    t.string "alzada"
    t.string "height"
    t.string "gender"
    t.string "video"
    t.integer "age"
    t.string "pedigree_type"
    t.index ["user_id"], name: "index_horses_on_user_id"
  end

  create_table "lotes", force: :cascade do |t|
    t.string "numero_lote"
    t.string "nombre_caballo"
    t.string "descripcion"
    t.date "fecha_nacimiento"
    t.string "sexo"
    t.string "alzada"
    t.string "pedigree"
    t.string "video"
    t.bigint "auction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_lotes_on_auction_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "tipo"
    t.string "description"
    t.bigint "conversation_id"
    t.bigint "horse_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "favorite_id"
    t.bigint "message_id"
    t.index ["conversation_id"], name: "index_notifications_on_conversation_id"
    t.index ["favorite_id"], name: "index_notifications_on_favorite_id"
    t.index ["horse_id"], name: "index_notifications_on_horse_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id", null: false
    t.integer "writer_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.integer "age"
    t.string "description"
    t.string "establishment"
    t.string "nombre"
    t.string "apellido"
    t.string "direccion"
    t.string "provincia"
    t.string "ciudad"
    t.string "pais"
    t.float "rating"
    t.integer "tier"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "auctions", "users"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "users"
  add_foreign_key "favorites", "auctions"
  add_foreign_key "favorites", "horses"
  add_foreign_key "favorites", "users"
  add_foreign_key "helps", "users"
  add_foreign_key "horses", "users"
  add_foreign_key "lotes", "auctions"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "conversations"
  add_foreign_key "notifications", "favorites"
  add_foreign_key "notifications", "horses"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "users"
  add_foreign_key "reviews", "users"
end
