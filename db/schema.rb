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

ActiveRecord::Schema[7.1].define(version: 2023_11_29_031603) do
  create_table "campaigns", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.integer "monto"
    t.string "imagen"
    t.date "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "activa", default: true
  end

  create_table "conditions", force: :cascade do |t|
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deworms", force: :cascade do |t|
    t.integer "cantidad"
    t.string "texto"
    t.integer "historial_turno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["historial_turno_id"], name: "index_deworms_on_historial_turno_id"
  end

  create_table "historial_turnos", force: :cascade do |t|
    t.string "franja"
    t.integer "tipo_turno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perro_id"
    t.integer "condition_id"
    t.string "texto"
    t.string "consulta"
    t.date "fecha"
    t.time "hora"
    t.index ["condition_id"], name: "index_historial_turnos_on_condition_id"
    t.index ["perro_id"], name: "index_historial_turnos_on_perro_id"
    t.index ["tipo_turno_id"], name: "index_historial_turnos_on_tipo_turno_id"
  end

  create_table "historial_vacunas", force: :cascade do |t|
    t.date "fecha"
    t.integer "vacuna_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perro_id"
    t.index ["perro_id"], name: "index_historial_vacunas_on_perro_id"
    t.index ["vacuna_id"], name: "index_historial_vacunas_on_vacuna_id"
  end

  create_table "perros", force: :cascade do |t|
    t.string "nombre"
    t.integer "edad"
    t.date "fecha_nacimiento"
    t.string "sexo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "raza_id"
    t.string "historial_anterior"
    t.index ["raza_id"], name: "index_perros_on_raza_id"
    t.index ["user_id"], name: "index_perros_on_user_id"
  end

  create_table "razas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rols", force: :cascade do |t|
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicios", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.integer "dni"
    t.string "zona"
    t.string "mail"
    t.string "tipo"
    t.string "horarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "habilitado"
  end

  create_table "tarjeta", force: :cascade do |t|
    t.integer "numero"
    t.string "nombre"
    t.integer "codigo"
    t.integer "saldo"
    t.date "vencimiento"
    t.integer "dni"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tarjetas", force: :cascade do |t|
    t.integer "numero"
    t.string "nombre"
    t.integer "codigo"
    t.integer "monto"
    t.date "vencimiento"
    t.integer "dni"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_turnos", force: :cascade do |t|
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "permission_level"
    t.integer "dni"
    t.string "nombre"
    t.string "apellido"
    t.date "fecha_nacimiento"
    t.string "mail"
    t.string "telefono"
    t.integer "rol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "habilitado", default: true
    t.boolean "donante", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_users_on_rol_id"
  end

  create_table "vaccines", force: :cascade do |t|
    t.integer "vacuna_id"
    t.integer "peso"
    t.string "texto"
    t.integer "historial_turno_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["historial_turno_id"], name: "index_vaccines_on_historial_turno_id"
    t.index ["vacuna_id"], name: "index_vaccines_on_vacuna_id"
  end

  create_table "vacunas", force: :cascade do |t|
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "deworms", "historial_turnos"
  add_foreign_key "historial_turnos", "conditions"
  add_foreign_key "historial_turnos", "perros"
  add_foreign_key "historial_turnos", "tipo_turnos"
  add_foreign_key "historial_vacunas", "perros"
  add_foreign_key "historial_vacunas", "vacunas"
  add_foreign_key "perros", "razas"
  add_foreign_key "perros", "users"
  add_foreign_key "users", "rols"
  add_foreign_key "vaccines", "historial_turnos"
  add_foreign_key "vaccines", "vacunas"
end
