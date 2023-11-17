class Schedule < ApplicationRecord
  belongs_to :cast
  belongs_to :position
  belongs_to :workday


  TIME_SLOTS = {
    "early_morning" => ["7:00～9:00", "7:00", "9:00"],
    "morning" => ["9:00～11:00", "9:00", "11:00"],
    "late_morning" => ["11:00～13:00", "11:00", "13:00"],
    "early_afternoon" => ["13:00～15:00", "13:00", "15:00"],
    "mid_afternoon" => ["15:00～17:00", "15:00", "17:00"],
    "late_afternoon" => ["17:00～19:00", "17:00", "19:00"],
    "evening" => ["19:00～21:00", "19:00", "21:00"],
    "night" => ["21:00～22:00", "21:00", "22:00"]
  }

  def time_slot
    TIME_SLOTS.key([start_time&.strftime("%H:%M"), end_time&.strftime("%H:%M")])
  end

  def time_slot=(slot)
    start_time_str, end_time_str = TIME_SLOTS[slot][1..2]
    base_date = Date.new(2000, 1, 1) 
    self.start_time = Time.zone.parse("#{base_date} #{start_time_str}")
    self.end_time = Time.zone.parse("#{base_date} #{end_time_str}")
  end

  def time_slot_text
    slot = time_slot
    return "" unless slot

    TIME_SLOTS[slot][0] 
 
  end

end
