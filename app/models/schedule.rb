class Schedule < ApplicationRecord
  include TimeSlotConstants

  belongs_to :cast
  belongs_to :position
  belongs_to :workday


  validates :cast_id,                     presence: true
  validates :position_id,                 presence: true
  validates :workday_id,                  presence: true
  validate :validate_time_slot
  validate :validate_unique_schedule_for_cast
  validate :validate_unique_position_schedule
  validate :cast_must_be_scheduled_on_workday
  validate :schedule_within_workday_hours

 

  def time_slot
    return nil if start_time.blank? || end_time.blank?

    formatted_start_time = start_time.strftime("%H:%M")
    formatted_end_time = end_time.strftime("%H:%M")
    TimeSlotConstants::TIME_SLOTS.find do |_, times|
      times[1] == formatted_start_time && times[2] == formatted_end_time
    end&.first
  end

  def time_slot=(slot)
    return unless TimeSlotConstants::TIME_SLOTS.has_key?(slot)

    start_time_str, end_time_str = TimeSlotConstants::TIME_SLOTS[slot][1..2]
    base_date = Date.new(2000, 1, 1) 
    self.start_time = Time.zone.parse("#{base_date} #{start_time_str}")
    self.end_time = Time.zone.parse("#{base_date} #{end_time_str}")
  end

  def time_slot_text
    slot = time_slot
    return "" unless slot

    TimeSlotConstants::TIME_SLOTS[slot][0]
  end

  private

  def validate_time_slot
    errors.add(:base, '不正な時間帯です') if start_time.nil? || end_time.nil?
  end

  def validate_unique_schedule_for_cast
    existing_schedule = Schedule.where.not(id: id)
    .where(cast_id: cast_id, workday_id: workday_id, start_time: start_time, end_time: end_time)
    errors.add(:base, '同じキャストは同じ時間帯に複数のスケジュールを設定できません') if existing_schedule.exists?
  end

  def validate_unique_position_schedule
    def validate_unique_position_schedule
      overlapping_schedule = Schedule.where.not(id: id)
                                      .where.not(cast_id: cast_id)
                                      .where(position_id: position_id, workday_id: workday_id)
                                      .where('(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?)',
                                             end_time, start_time, start_time, end_time)
      errors.add(:base, '異なるキャストは同じポジションで同じ時間帯にスケジュールされています') if overlapping_schedule.exists?
    end
  end

  def cast_must_be_scheduled_on_workday
    return if cast_id.blank? || workday_id.blank?

    unless Workday.exists?(id: workday_id, cast_id: cast_id)
      errors.add(:base, 'スケジュールされたキャストは指定された日に勤務していません。')
    end
  end

  def schedule_within_workday_hours
    return if workday_id.blank? || start_time.blank? || end_time.blank?
  
    workday = Workday.find(workday_id)
    Rails.logger.debug "Workday Hours: #{workday.start_time} - #{workday.end_time}"
    Rails.logger.debug "Schedule Hours: #{start_time} - #{end_time}"
  
    unless workday.start_time <= start_time && workday.end_time >= end_time
      errors.add(:base, 'スケジュールされた時間は勤務時間内にある必要があります。')
    end
  end
end