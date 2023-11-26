class BrakeTime < ApplicationRecord
  def self.find_appropriate_rule(work_duration)
    where("min_work_duration <= ? AND max_work_duration >= ?", work_duration, work_duration).first
  end
end

