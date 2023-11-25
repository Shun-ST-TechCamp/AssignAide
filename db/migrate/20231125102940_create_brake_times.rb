class CreateBrakeTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :brake_times do |t|

      t.timestamps
    end
  end
end
