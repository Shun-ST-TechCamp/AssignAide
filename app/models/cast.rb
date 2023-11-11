class Cast < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :first_name, presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,message: "全角カタカナのみで入力して下さい"}
         validates :family_name, presence: true,format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,message: "全角カタカナのみで入力して下さい"}
         validates :company_id, presence: true, uniqueness: true, numericality: {only_integer: true}, length: { in: 8,message: "8桁で入力してください" },
                                                                  format: { with: /\A[0-9]+\z/ }
         validates :health, presence:true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100,message: "0から100で入力してください" }
         validates :sara_shiwake_skill, presence:true
         validates :sara_arai_skill, presence:true
         validates :sara_nagashi_skill, presence:true
         validates :sara_huki_skill, presence:true
         validates :kigu_arai_skill, presence:true
         validates :kigu_nagashi_skill, presence:true
         validates :silver_migaki_skill, presence:true

         def was_attached?
          image.attached?
         end

         has_one_attached :image
end
