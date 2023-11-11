class RenameSkillColumnsInCasts < ActiveRecord::Migration[7.0]
  def change
    rename_column :casts, :sara_shiwake_skill, :sara_shiwake_skill_id
    rename_column :casts, :sara_arai_skill, :sara_arai_skill_id
    rename_column :casts, :sara_nagashi_skill, :sara_nagashi_skill_id
    rename_column :casts, :sara_huki_skill, :sara_huki_skill_id
    rename_column :casts, :kigu_arai_skill, :kigu_arai_skill_id
    rename_column :casts, :kigu_nagashi_skill, :kigu_nagashi_skill_id
    rename_column :casts, :kigu_huki_skill, :kigu_huki_skill_id
    rename_column :casts, :silver_migaki_skill, :silver_migaki_skill_id
  end
end
