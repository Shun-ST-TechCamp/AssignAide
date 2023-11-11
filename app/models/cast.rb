class Cast < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :first_name, presence: true
         validates :family_name, presence: true
         validates :company_id, presence: true, uniqueness: true
         validates :health, presence:true
         validates :sara_shiwake_skill, presence:true
         validates :sara_arai_skill, presence:true
         validates :sara_nagashi_skill, presence:true
         validates :sara_huki_skill, presence:true
         validates :kigu_arai_skill, presence:true
         validates :kigu_nagashi_skill, presence:true
         validates :silver_migaki_skill, presence:true
         validates :image,               presence: true


         def image_presence
          errors.add(:image, "must be attached") unless image.attached?
        end
         def was_attached?
          image.attached?
         end

         has_one_attached :image
end
