class Schedule < ApplicationRecord
  belongs_to :cast
  belongs_to :position
  belongs_to :workday


  validates :cast_id,                     presence: true
  validates :position_id,                 presence: true
  validates :workday_id,                  presence: true
  validate :validate_time_slot
  validate :validate_unique_schedule_for_cast
  validate :validate_unique_position_schedule

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
    return unless TIME_SLOTS.has_key?(slot)

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

  private

  def validate_time_slot
    errors.add(:base, '不正な時間帯です') if start_time.nil? || end_time.nil?
  end

  def validate_unique_schedule_for_cast
    existing_schedule = Schedule.where(cast_id: cast_id, workday_id: workday_id, start_time: start_time, end_time: end_time)
    errors.add(:base, '同じキャストは同じ時間帯に複数のスケジュールを設定できません') if existing_schedule.exists?
  end

  def validate_unique_position_schedule
    overlapping_schedule = Schedule.where.not(cast_id: cast_id)
                                   .where(position_id: position_id, workday_id: workday_id)
                                   .where('(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?)',
                                          end_time, start_time, start_time, end_time)
    errors.add(:base, '異なるキャストは同じポジションで同じ時間帯にスケジュールされています') if overlapping_schedule.exists?
  end
end