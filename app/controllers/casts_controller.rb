class CastsController < ApplicationController
  before_action :authenticate_cast!, only: [:index, :show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @casts = Cast.all
  end

  def edit

  end

  def update

    if @cast.update(cast_params)
      redirect_to casts_path, notice: 'キャストの情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def cast_params
    if current_cast.admin?
      params.require(:cast).permit(:first_name, :family_name, :company_id, :health, :sara_shiwake_skill_id, :sara_arai_skill_id, :sara_nagashi_skill_id, :sara_huki_skill_id, :kigu_arai_skill_id, :kigu_nagashi_skill_id, :kigu_huki_skill_id, :silver_migaki_skill_id)
    else
      params.require(:cast).permit(:email, :password, :password_confirmation, :current_password)
    end
  end
end
