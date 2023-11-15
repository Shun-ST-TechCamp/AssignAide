class Workday < ApplicationRecord
  has_many :schedules
  belongs_to :cast
end
