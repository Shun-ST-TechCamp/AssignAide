# AssignAide

## アプリケーション概要
  このアプリケーションは、アルバイトを職場のポジションに自動で配置するアプリケーション。  
  また、勤務情報をウェブ上で確認することができる。

## URL
https://assignaide.onrender.com/
## テスト用アカウント(管理者権限が付与されています)
    Campany:12345678
    Password:123456a
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
  アルバイトを管理する管理者や、ウェブ上で勤務情報を確認したいアルバイトのために作成した。  
  ポジションの配置はポジションリーダーが毎日、出勤してすぐに完成させなければいけないため、とても忙しい業務となっていた。  
  慣れている人なら30分ほどで終わる作業とはいえ、それを自動化し業務の負担を軽減できればと思い作成した。
  また、手作業で勤務情報をメモに写すとなると、写し間違えのリスクがあるためそのような問題を解決できるよう、ウェブで勤務情報を確認できればと思い作成した。
## 要件定義
  https://docs.google.com/spreadsheets/d/1p4524lgo3DOmaOV5uoeIyPOwIxf1t_2wQPLWNMCYfyE/edit#gid=982722306

## 使い方
### 配置の仕方
  [![Image from Gyazo](https://i.gyazo.com/e52475912292b78a6d4a7dfa5bfa4b1c.gif)](https://gyazo.com/e52475912292b78a6d4a7dfa5bfa4b1c)

## 実装予定の機能
  - ログインしている人しか見れない機能
  - 自動配置するための機能  
  - 管理者のみ変更ができる機能  
## DB設計
[![Image from Gyazo](https://i.gyazo.com/2b18f3de50a9ab80d2d6e0e011066b84.png)](https://gyazo.com/2b18f3de50a9ab80d2d6e0e011066b84)

## テーブル設計
### castsテーブル

| Column                 | Type   | Options                   |
| -----------------------| ------ | ------------------------- |
| first_name             | string | null: false               |
| family_name            | string | null: false               |
| company_id             | integer| null: false, unique: true |
| encrypted_password     | string | null: false               |
| health                 | integer| null: false               |
| sara_shiwake_skill_id  | integer| null: false               |
| sara_arai_skill_id     | integer| null: false               |
| sara_nagashi_skill_id  | integer| null: false               |
| sara_huki_skill_id     | integer| null: false               |
| kigu_arai_skill_id     | integer| null: false               |
| kigu_nagashi_skill_id  | integer| null: false               |
| kigu_huki_skill_id     | integer| null: false               |
| silver_migaki_skill_id | integer| null: false               |

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

- `sara_shiwake_skill`, `sara_arai_skill`, `sara_nagashi_skill`, `sara_huki_skill`, `kigu_arai_skill`, `kigu_nagashi_skill`, `kigu_huki_skill`, `silver_migaki_skill` の各カラムは、ActiveHashを使用して管理されます。それらは `SkillLevel` ActiveHashモデルを使用し、それぞれのカラムは `belongs_to_active_hash` アソシエーションを持つ。

- brake_timesテーブルは、workdayモデルでstart_timeとend_timeを元に勤務時間を計算し、BrakeTimeモデルで休憩時間を決定するために使用される。他のモデルとは関連付けられていないが、WorkdayやScheduleモデルで使用される。

## 画面遷移図
### 予定
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
db/seeds.rbファイルのコメントアウトを外し、18行目の[10].times doの数字を追加したいアルバイトキャストの数に変更
rails db:seed
#### 管理者権限の付与の仕方 (コンソール画面にて実行)
cast = Cast.find(company_id:********) *を追加したキャストのcompany_idを指定  
cast.admin = true
cast.save


## 工夫したポイント
なるべくフォームから入力をすることなく、簡単にポジションの配置ができるように工夫した。