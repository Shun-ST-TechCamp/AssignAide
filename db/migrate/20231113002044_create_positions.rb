class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.string  :position_name,         null: false
      t.integer :capacity,              null: false
      t.integer :fatigue_level,         null: false
      t.integer :position_type,         null: false
      t.integer :equired_skill_level,   null: false
      t.timestamps
    end
  end
end
