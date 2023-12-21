class Workday < ApplicationRecord
  has_many :schedules, dependent: :destroy
  belongs_to :cast

  validates :cast_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_unique_workday_for_cast

  after_save :handle_break_schedule

  def break_time
    work_duration = (end_time - start_time) / 60 # 分単位で勤務時間を計算
    brake_rule = BrakeTime.find_by('min_work_duration <= ? AND max_work_duration >= ?', work_duration, work_duration)
    brake_rule ? brake_rule.break_duration : 0
  end

  def break_schedule_limit_exceeded?(break_start_time, break_end_time)
    overlapping_break_schedules = Schedule.joins(:workday)
                                          .where(position_id: break_position_id, workdays: {date: date})
                                          .where('schedules.start_time < ? AND schedules.end_time > ?', break_end_time, break_start_time)
    overlapping_break_schedules.count >= 3
  end

  def break_position_id
    @break_position_id ||= Position.find_by(position_name: 'brake').id
  end


    ## テスト用の一時的なパブリックメソッド

    # def test_assign_break_to_time_slot
    #   assign_break_to_time_slot
    # end

    # def test_calculate_break_start_time
    #   calculate_break_start_time
    # end

    # def test_create_or_update_break_schedule(start_time, time_slot)
    #   create_or_update_break_schedule(start_time, time_slot)
    # end

    # def test_calculate_break_start_time
    #   calculate_break_start_time
    # end

    ## テスト用の一時的なパブリックメソッド

  private
  def validate_unique_workday_for_cast
    existing_workday = Workday.where(cast_id: cast_id, date: date)
    if existing_workday.exists? && (new_record? || existing_workday.where.not(id: id).exists?)
      errors.add(:base, '同じキャストは同じ日に複数のワークデイを持つことはできません。')
    end
  end

  def handle_break_schedule
    if new_record?
      create_break_schedule
    else
      update_break_schedule
    end
  end
    
  def validate_unique_workday_for_cast
    existing_workday = Workday.where(cast_id: cast_id, date: date)
    if existing_workday.exists? && (new_record? || existing_workday.where.not(id: id).exists?)
      errors.add(:base, '同じキャストは同じ日に複数のワークデイを持つことはできません。')
    end
  end

  def calculate_break_start_time
    # 休憩時間の長さを取得
    break_duration = break_time
  
    # 休憩終了の最遅時間（勤務終了時間の3時間前）
    latest_end_break_time = end_time - 3.hours
  
    # 休憩終了の最早時間（勤務終了時間の6時間45分前）
    earliest_end_break_time = end_time - (6.hours + 45.minutes)
  
    # 休憩開始の最早時間（休憩終了の最早時間から休憩時間を引いた時間）
    earliest_start_break_time = earliest_end_break_time - break_duration.minutes
  
    # 休憩開始時間が休憩終了時間を超えないように調整
    [earliest_start_break_time, latest_end_break_time - break_duration.minutes].max
  end

  ###使用されていない
  # def calculate_and_assign_break_schedule
  #   break_start_time = calculate_break_start_time
  #   break_end_time = break_start_time + break_time.minutes
  #   create_or_update_break_schedule(break_start_time, break_end_time)
  # end

  # def create_or_update_break_schedule(start_time, end_time)
  #   Rails.logger.debug "Creating or updating break schedule for Workday ID: #{id}"
  #   break_position = Position.find_by(position_name: 'brake')

  #   existing_break_schedule = schedules.find_by(position_id: break_position.id)

  #   if existing_break_schedule
  #     Rails.logger.debug "Updating existing break schedule for Workday ID: #{id}"
  #     existing_break_schedule.update(start_time: start_time, end_time: end_time)
  #   else
  #     Rails.logger.debug "Creating new break schedule for Workday ID: #{id}"
  #     schedules.create!(
  #       cast_id: cast_id,
  #       position_id: break_position.id,
  #       start_time: start_time,
  #       end_time: end_time
  #     )
  #   end
  # end
  ###使用されていない可能性あり

  def create_break_schedule
    break_duration = break_time
    if break_duration > 0
      start_break_time = calculate_break_start_time
      end_break_time = start_break_time + break_duration.minutes

      unless break_schedule_limit_exceeded?(start_break_time, end_break_time)
        break_position = Position.find_by(position_name: 'brake')
        schedules.create!(
          cast_id: cast_id,
          position_id: break_position.id,
          start_time: start_break_time,
          end_time: end_break_time
        )
      end
    end
  end

  def update_break_schedule
    break_position = Position.find_by(position_name: 'brake')
    existing_break_schedule = schedules.find_by(position_id: break_position.id)
  
    if break_time.zero? && existing_break_schedule
      existing_break_schedule.destroy
      return
    end
  
    if existing_break_schedule
      start_break_time = calculate_break_start_time
      existing_break_schedule.update(
        start_time: start_break_time,
        end_time: start_break_time + break_time.minutes
      )
    else
      create_break_schedule
    end
  end

  # def assign_break_to_time_slot
  #   Rails.logger.debug "Assigning break to time slot for Workday ID: #{id}"
  
  #   calculated_start_time = calculate_break_start_time
  #   calculated_end_time = calculated_start_time + break_time.minutes
  
  #   # 休憩時間を含むタイムスロットを探す
  #   matching_time_slot = Schedule::TIME_SLOTS.find do |_, times|
  #     slot_start = Time.zone.parse("#{date} #{times[1]}")
  #     slot_end = Time.zone.parse("#{date} #{times[2]}")
  #     calculated_end_time >= slot_start && calculated_end_time <= slot_end
  #   end
  
  #   if matching_time_slot
  #     Rails.logger.debug "Found matching time slot: #{matching_time_slot.first} for Workday ID: #{id}"
      
  #     create_or_update_break_schedule(calculated_start_time, calculated_end_time)
  #   else
  #     Rails.logger.debug "No matching time slot found for Workday ID: #{id}"
  #   end
  # end

end