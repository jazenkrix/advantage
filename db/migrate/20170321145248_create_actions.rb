class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.string :desc
      t.string :action_type, default: nil
      t.integer :to_hit, default: 0
      t.string :damage
      t.integer :creature_id
    end
  end
end
