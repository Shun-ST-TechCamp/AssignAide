class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :cast,           null:false, foreign_key: true
      t.references :position,           null:false, foreign_key: true
      t.date :date,                 null:false
      t.time :start_time,           null:false
      t.time :end_time,             null:false
      t.timestamps
    end
  end
end
