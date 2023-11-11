class CastsController < ApplicationController
  before_action :authenticate_cast!, only: [:index, :show, :edit, :update, :destroy]
  def index
    @casts = Cast.all
  end

  def edit
    @cast = Cast.find(params[:id])
  end

  def update
    @cast = Cast.find(params[:id])
    if @cast.update(cast_params)
      redirect_to casts_path, notice: 'キャストの情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def cast_params
    params.require(:cast).permit(:first_name, :family_name, :company_id, :health, :sara_shiwake_skill_id, :sara_arai_skill_id, :sara_nagashi_skill_id, :sara_huki_skill_id, :kigu_arai_skill_id, :kigu_nagashi_skill_id, :silver_migaki_skill_id)
  end
end
