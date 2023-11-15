class Schedule < ApplicationRecord
 belongs_to :cast
 belongs_to :position
 belongs_to :workday
end
