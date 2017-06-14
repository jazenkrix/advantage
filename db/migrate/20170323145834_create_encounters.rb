class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.string :name
      t.string :description
      t.integer :turn, defualt: 0
    end
  end
end
