class CastsController < ApplicationController
  before_action :authenticate_cast!, only: [:index, :show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @casts = Cast.all
  end
  
  def show
    @cast = Cast.find(params[:id])
    @workdays = @cast.workdays
  end
  

  def edit

  end

  def update

    if @cast.update(cast_params)
      if params[:cast][:image].present?
        @cast.image.attach(params[:cast][:image])
      end
      redirect_to casts_path, notice: 'キャストの情報を更新しました。'
    else
      render :edit
    end
  end

  private

  def cast_params
    permitted_attributes = [:first_name, :family_name, :company_id, :health, :sara_shiwake_skill_id, :sara_arai_skill_id, :sara_nagashi_skill_id, :sara_huki_skill_id, :kigu_arai_skill_id, :kigu_nagashi_skill_id, :kigu_huki_skill_id, :silver_migaki_skill_id, :image]
    if current_cast.admin?
      params.require(:cast).permit(permitted_attributes)
    else
      params.require(:cast).permit(:email, :password, :password_confirmation, :current_password, :image)
    end
  end

  protected

  def current_ability
    @current_ability ||= Ability.new(current_cast)
  end
end
