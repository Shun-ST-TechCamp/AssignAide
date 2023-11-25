class CreateBrakeTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :brake_times do |t|
      t.integer :min_work_duration
      t.integer :max_work_duration
      t.integer :break_duration

      t.timestamps
    end
  end
end