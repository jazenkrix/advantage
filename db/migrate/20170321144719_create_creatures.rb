class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
      t.string :name
      t.string :size
      t.string :category
      t.string :subtype
      t.string :alignment
      t.string :armor_class
      t.string :armor_type
      t.integer :hit_points
      t.string :hit_dice
      t.string :speed
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.string :saving_throws
      t.string :skills
      t.string :dmg_vulnerabilities
      t.string :dmg_resistances
      t.string :dmg_immunities
      t.string :con_immunities
      t.string :senses
      t.string :languages
      t.string :challenge_rating
      t.boolean :pc
      t.boolean :npc
      t.boolean :monster
    end
  end
end
