# frozen_string_literal: true

class DeviseCreateCasts < ActiveRecord::Migration[7.0]
  def change
    create_table :casts do |t|
      ## Database authenticatable
      t.string  :email,              null: false, default: ""
      t.string  :encrypted_password, null: false, default: ""
      t.string  :first_name,         null: false
      t.string  :family_name,        null: false
      t.integer :company_id,         null: false, unique: true
      t.integer :health,             null: false, default: 100
      t.integer :sara_shiwake_skill, null: false, default: 1
      t.integer :sara_arai_skill,    null: false, default: 1
      t.integer :sara_nagashi_skill, null: false, default: 1
      t.integer :sara_huki_skill,    null: false, default: 1
      t.integer :kigu_arai_skill,    null: false, default: 1
      t.integer :kigu_nagashi_skill, null: false, default: 1
      t.integer :kigu_huki_skill,    null: false, default: 1
      t.integer :silver_migaki_skill,  null: false, default: 1

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :casts, :email,                unique: true
    add_index :casts, :reset_password_token, unique: true
    # add_index :casts, :confirmation_token,   unique: true
    # add_index :casts, :unlock_token,         unique: true
  end
end
