# positions = Position.create([
#   { position_name: 'sara_shiwake', capacity: 2, fatigue_level: 40, position_type: 0, required_skill_level: 2 },
#   { position_name: 'sara_arai', capacity: 1, fatigue_level: 30, position_type: 0, required_skill_level: 2 },
#   { position_name: 'sara_nagashi', capacity: 1, fatigue_level: 20, position_type: 0, required_skill_level: 2 },
#   { position_name: 'sara_huki', capacity: 2, fatigue_level: 10, position_type: 1, required_skill_level: 2 },
#   { position_name: 'kigu_arai', capacity: 1, fatigue_level: 30, position_type: 0, required_skill_level: 2 },
#   { position_name: 'kigu_nagashi', capacity: 1, fatigue_level: 20, position_type: 0, required_skill_level: 2 },
#   { position_name: 'kigu_huki', capacity: 2, fatigue_level: 10, position_type: 1, required_skill_level: 2 },
#   { position_name: 'silver_migaki', capacity: 1, fatigue_level: 10, position_type: 1, required_skill_level: 2 },
#   { position_name: 'extra', capacity: 99, fatigue_level: 0, position_type: 2, required_skill_level: 1 }
# ])

require 'faker'
require 'gimei'

Faker::Config.locale = 'ja'

10.times do
  person = Gimei.name

  Cast.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: person.first.katakana,
    family_name: person.last.katakana,
    company_id: Faker::Number.number(digits: 8),
    health: 100,
    sara_shiwake_skill_id: rand(2..4),
    sara_arai_skill_id: rand(2..4),
    sara_nagashi_skill_id: rand(2..4),
    sara_huki_skill_id: rand(2..4),
    kigu_arai_skill_id: rand(2..4),
    kigu_nagashi_skill_id: rand(2..4),
    kigu_huki_skill_id: rand(2..4),
    silver_migaki_skill_id: rand(2..4)
  )
end