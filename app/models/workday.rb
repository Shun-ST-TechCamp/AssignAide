class Workday < ApplicationRecord
  has_many :schedules
  belongs_to :cast

  validates :date, presence: true
  
end