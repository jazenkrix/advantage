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

ActiveRecord::Schema.define(version: 20170321145248) do

  create_table "actions", force: :cascade do |t|
    t.string  "name"
    t.string  "desc"
    t.string  "action_type"
    t.integer "to_hit",      default: 0
    t.string  "damage"
    t.integer "creature_id"
  end

  create_table "creatures", force: :cascade do |t|
    t.string  "name"
    t.string  "size"
    t.string  "category"
    t.string  "subtype"
    t.string  "alignment"
    t.string  "armor_class"
    t.string  "armor_type"
    t.integer "hit_points"
    t.string  "hit_dice"
    t.string  "speed"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string  "saving_throws"
    t.string  "skills"
    t.string  "dmg_vulnerabilities"
    t.string  "dmg_resistances"
    t.string  "dmg_immunities"
    t.string  "con_immunities"
    t.string  "senses"
    t.string  "languages"
    t.string  "challenge_rating"
    t.boolean "pc"
    t.boolean "npc"
    t.boolean "monster"
  end

  create_table "special_abilities", force: :cascade do |t|
    t.string  "name"
    t.string  "desc"
    t.integer "creature_id"
  end

end
