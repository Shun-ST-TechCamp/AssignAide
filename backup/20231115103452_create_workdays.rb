class CreateWorkdays < ActiveRecord::Migration[7.0]
  def change
    create_table :workdays do |t|
      t.references :cast,           null:false, foreign_key: true
      t.date       :date,           null:false
      t.time       :start_time,     null:false
      t.time       :end_time,       null:false
      t.timestamps
    end
  end
end
