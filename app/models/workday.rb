class Workday < ApplicationRecord
  has_many :schedules, dependent: :destroy
  belongs_to :cast

  validates :cast_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time,  presence:true
  validate :validate_unique_workday_for_cast

  private

  def validate_unique_workday_for_cast
    existing_workday = Workday.where(cast_id: cast_id, date: date)
    if existing_workday.exists? && (new_record? || existing_workday.where.not(id: id).exists?)
      errors.add(:base, '同じキャストは同じ日に複数のワークデイを持つことはできません。')
    end
  end
end