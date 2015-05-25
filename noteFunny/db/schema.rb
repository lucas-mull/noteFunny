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

ActiveRecord::Schema.define(version: 20150522082550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appartenances", force: :cascade do |t|
    t.integer "matiere_id",  null: false
    t.integer "etudiant_id", null: false
  end

  create_table "epreuves", force: :cascade do |t|
    t.string  "titre",      limit: 20, null: false
    t.date    "date",                  null: false
    t.integer "matiere_id",            null: false
  end

  create_table "matieres", force: :cascade do |t|
    t.string  "titre",         limit: 20, null: false
    t.date    "debut",                    null: false
    t.date    "fin",                      null: false
    t.integer "enseignant_id",            null: false
    t.string  "description"
  end

  create_table "resultats", force: :cascade do |t|
    t.integer "valeur"
    t.integer "etudiant_id", null: false
    t.integer "epreuve_id",  null: false
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.string "nom",             limit: 50,  null: false
    t.string "prenom",          limit: 50,  null: false
    t.string "email",           limit: 100, null: false
    t.string "password_digest",             null: false
    t.string "etat"
    t.string "type"
  end

end
