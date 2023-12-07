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

  private

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

  def create_break_schedule
    break_duration = break_time
    if break_duration > 0
      break_position = Position.find_by(position_name: 'brake')
      start_break_time = calculate_break_start_time
      Schedule.create!(
        cast_id: cast_id,
        position_id: break_position.id,
        workday_id: id,
        start_time: start_break_time,
        end_time: start_break_time + break_duration.minutes
      )
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
end