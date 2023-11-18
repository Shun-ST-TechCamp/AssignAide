class Workday < ApplicationRecord
  has_many :schedules
  belongs_to :cast

  TIME_SLOTS = Schedule::TIME_SLOTS

  validates :date, presence: true
  validate :validate_time_slot


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

  private

  def validate_time_slot
    errors.add(:base, '不正な時間帯です') if start_time.nil? || end_time.nil?
  end
end