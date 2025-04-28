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

ActiveRecord::Schema[8.0].define(version: 2025_03_26_164547) do
  create_table "customer_users", id: :string, force: :cascade do |t|
    t.string "customer_id", null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_users_on_customer_id"
    t.index ["user_id"], name: "index_customer_users_on_user_id"
  end

  create_table "customers", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "cellphone", null: false
    t.string "cpf_cnpj"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_accepted_terms", default: false
  end

  create_table "orders", id: :string, force: :cascade do |t|
    t.string "customer_user_id", null: false
    t.string "product_id"
    t.decimal "value", precision: 10, scale: 2, null: false
    t.string "status", null: false
    t.string "order_type", null: false
    t.decimal "points", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "whatsapp_message_id"
    t.index ["customer_user_id"], name: "index_orders_on_customer_user_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["whatsapp_message_id"], name: "index_orders_on_whatsapp_message_id"
  end

  create_table "products", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "cellphone", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.decimal "tax", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "whodunnit"
    t.datetime "created_at"
    t.string "item_id", null: false
    t.string "item_type", null: false
    t.string "event", null: false
    t.text "object", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "whatsapp_messages", id: :string, force: :cascade do |t|
    t.string "message_id", null: false
    t.string "status", null: false
    t.string "template"
    t.string "customer_id", null: false
    t.string "error_message"
    t.string "error_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_whatsapp_messages_on_customer_id"
  end

  add_foreign_key "customer_users", "customers"
  add_foreign_key "customer_users", "users"
  add_foreign_key "orders", "customer_users"
  add_foreign_key "orders", "products"
  add_foreign_key "products", "users"
end
