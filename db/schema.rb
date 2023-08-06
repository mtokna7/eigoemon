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

ActiveRecord::Schema[7.0].define(version: 2023_08_06_152041) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "level", null: false
    t.text "content", null: false
    t.integer "speaker", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", null: false
  end

  create_table "quiz_choices", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.string "furigana"
    t.boolean "is_correct", default: false
    t.integer "bold_start"
    t.integer "bold_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_choices_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_quizzes_on_word_id"
  end

  create_table "user_quiz_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "word_id", null: false
    t.bigint "quiz_choice_id", null: false
    t.boolean "is_correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_choice_id"], name: "index_user_quiz_histories_on_quiz_choice_id"
    t.index ["user_id"], name: "index_user_quiz_histories_on_user_id"
    t.index ["word_id"], name: "index_user_quiz_histories_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", default: 0, null: false
    t.boolean "leveled_up", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "name", null: false
    t.text "programming_explanation", null: false
    t.text "english_explanation", null: false
    t.string "furigana", null: false
    t.integer "bold_start"
    t.integer "bold_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_words_on_name", unique: true
  end

  add_foreign_key "quiz_choices", "quizzes"
  add_foreign_key "quizzes", "words"
  add_foreign_key "user_quiz_histories", "quiz_choices"
  add_foreign_key "user_quiz_histories", "users"
  add_foreign_key "user_quiz_histories", "words"
end
