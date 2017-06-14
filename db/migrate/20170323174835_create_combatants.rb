class CreateCombatants < ActiveRecord::Migration
  def change
    create_table :combatants do |t|
      t.integer :encounter_id
      t.integer :creature_id
      t.integer :initiative
      t.integer :round, default: 0
      t.integer :health
      t.string :notes
    end
  end
end
