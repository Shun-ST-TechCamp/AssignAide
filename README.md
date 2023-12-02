# テーブル設計

## castsテーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| first_name          | string | null: false               |
| family_name         | string | null: false               |
| company_id          | integer| null: false, unique: true |
| encrypted_password  | string | null: false               |
| health              | integer| null: false               |
| sara_shiwake_skill  | integer| null: false               |
| sara_arai_skill     | integer| null: false               |
| sara_nagashi_skill  | integer| null: false               |
| sara_huki_skill     | integer| null: false               |
| kigu_arai_skill     | integer| null: false               |
| kigu_nagashi_skill  | integer| null: false               |
| kigu_huki_skill     | integer| null: false               |
| silver_migaki_skill | integer| null: false               |

### Association
- has_many   :schedules
- has_many   :workdays

## positionsテーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| position_name        | string  | null: false |
| capacity             | integer | null: false |
| fatigue_level        | integer | null: false |
| position_type        | integer | null: false |
| required_skill_level | integer | null: false |

### Association
- has_many :schedules

## schedulesテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| cast_id           | references | null: false, foreign_key: true |
| position_id       | references | null: false, foreign_key: true |
| workday_id        | references | null: false, foreign_key: true |
| start_time        | time       | null: false                    |
| end_time          | time       | null: false                    |

### Association
- belongs_to :cast
- belongs_to :position
- belongs_to :workday

## workdaysテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| cast_id           | references | null: false, foreign_key: true |
| date              | date       | null: false                    |
| start_time        | time       | null: false                    |
| end_time          | time       | null: false                    |

### Association
- has_many :schedules
- belongs_to :cast

## brake_timesテーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| min_work_duration    | integer |             |
| max_work_duration    | integer |             |
| break_duration       | integer |             |



## 注釈

- `sara_shiwake_skill`, `sara_arai_skill`, `sara_nagashi_skill`, `sara_huki_skill`, `kigu_arai_skill`, `kigu_nagashi_skill`, `kigu_huki_skill`, `silver_migaki_skill` の各カラムは、ActiveHashを使用して管理されます。それらは `SkillLevel` ActiveHashモデルを使用し、それぞれのカラムは `belongs_to_active_hash` アソシエーションを持ちます。

- brake_timesテーブルは、workdayモデルでstart_timeとend_timeを元に勤務時間を計算し、BrakeTimeモデルで休憩時間を決定するために使用されます。他のモデルとは関連付けられていませんが、WorkdayやScheduleモデルで使用されます。