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

ActiveRecord::Schema.define(version: 2021_03_21_194636) do

  create_table "exectests", force: :cascade do |t|
    t.integer "qa_id", null: false
    t.integer "suite_id", null: false
    t.integer "teste_id", null: false
    t.string "execucao_uuid"
    t.string "data_inicio"
    t.string "data_fim"
    t.string "status"
    t.string "evidencia"
    t.string "comentario"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qa_id"], name: "index_exectests_on_qa_id"
    t.index ["suite_id"], name: "index_exectests_on_suite_id"
    t.index ["teste_id"], name: "index_exectests_on_teste_id"
  end

  create_table "qas", force: :cascade do |t|
    t.string "nome"
    t.string "tribo"
    t.string "squad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.integer "suite_id", null: false
    t.integer "teste_id", null: false
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["suite_id"], name: "index_steps_on_suite_id"
    t.index ["teste_id"], name: "index_steps_on_teste_id"
  end

  create_table "suites", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "testes", force: :cascade do |t|
    t.integer "suite_id", null: false
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["suite_id"], name: "index_testes_on_suite_id"
  end

  add_foreign_key "exectests", "qas"
  add_foreign_key "exectests", "suites"
  add_foreign_key "exectests", "testes", column: "teste_id"
  add_foreign_key "steps", "suites"
  add_foreign_key "steps", "testes", column: "teste_id"
  add_foreign_key "testes", "suites"
end
