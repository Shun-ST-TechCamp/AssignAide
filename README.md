# AssignAide

## アプリケーション概要
  このアプリケーションは、アルバイトを職場のポジションに自動で配置するアプリケーションです。

## URL

## テスト用アカウント
  ### Basic認証
    ユーザー名:admin
    パスワード:2222

## 利用方法
  - サイドバーの"スケジュール"をクリック  
  - 上の"勤務日を追加"をクリック  
  - フォームから勤務日を送信  
  - サイドバーの"ポジション表示"をクリック  
  - 勤務時間内のタイムスロットで、"配置"をクリック  
  - フォームから選択する 

## アプリケーションを作成した背景
  アルバイトを管理する管理者や、Web上でスケジュールを確認したいアルバイトのために作成しました。

## 要件定義
  [URL](https://docs.google.com/spreadsheets/d/1p4524lgo3DOmaOV5uoeIyPOwIxf1t_2wQPLWNMCYfyE/edit#gid=982722306) 

## 使い方
### 配置の仕方
  [![Image from Gyazo](https://i.gyazo.com/e52475912292b78a6d4a7dfa5bfa4b1c.gif)](https://gyazo.com/e52475912292b78a6d4a7dfa5bfa4b1c)

## 実装予定の機能
  - 自動配置するための機能  
  - 管理者のみ変更ができる機能  
## DB設計
[![Image from Gyazo](https://i.gyazo.com/2b18f3de50a9ab80d2d6e0e011066b84.png)](https://gyazo.com/2b18f3de50a9ab80d2d6e0e011066b84)

## テーブル設計
### castsテーブル

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

#### Association
- has_many   :schedules
- has_many   :workdays

### positionsテーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| position_name        | string  | null: false |
| capacity             | integer | null: false |
| fatigue_level        | integer | null: false |
| position_type        | integer | null: false |
| required_skill_level | integer | null: false |

#### Association
- has_many :schedules

### schedulesテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| cast_id           | references | null: false, foreign_key: true |
| position_id       | references | null: false, foreign_key: true |
| workday_id        | references | null: false, foreign_key: true |
| start_time        | time       | null: false                    |
| end_time          | time       | null: false                    |

#### Association
- belongs_to :cast
- belongs_to :position
- belongs_to :workday

### workdaysテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| cast_id           | references | null: false, foreign_key: true |
| date              | date       | null: false                    |
| start_time        | time       | null: false                    |
| end_time          | time       | null: false                    |

#### Association
- has_many :schedules
- belongs_to :cast

### brake_timesテーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| min_work_duration    | integer |             |
| max_work_duration    | integer |             |
| break_duration       | integer |             |



### 注釈

- `sara_shiwake_skill`, `sara_arai_skill`, `sara_nagashi_skill`, `sara_huki_skill`, `kigu_arai_skill`, `kigu_nagashi_skill`, `kigu_huki_skill`, `silver_migaki_skill` の各カラムは、ActiveHashを使用して管理されます。それらは `SkillLevel` ActiveHashモデルを使用し、それぞれのカラムは `belongs_to_active_hash` アソシエーションを持ちます。

- brake_timesテーブルは、workdayモデルでstart_timeとend_timeを元に勤務時間を計算し、BrakeTimeモデルで休憩時間を決定するために使用されます。他のモデルとは関連付けられていませんが、WorkdayやScheduleモデルで使用されます。

## 画面遷移図
### 予定です
[![Image from Gyazo](https://i.gyazo.com/6615c8b7b2fecc7a17e172d7bd7c1cb3.png)](https://gyazo.com/6615c8b7b2fecc7a17e172d7bd7c1cb3)

## 開発言語
- Ruby on Rails
- HTML
- CSS
- Javascript

## ローカルでの動作方法
### 以下のコマンドを順に実行
git clone https://github.com/Shun-ST-TechCamp/AssignAide.git
cd AssignAide
bundle install
yarn install

## 工夫したポイント
なるべくフォームから入力をすることなく、簡単にポジションの配置ができるように工夫しました。