class CastsController < ApplicationController
  before_action :authenticate_cast!
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction

  def index
      @casts = Cast.order(sort_column + " " + sort_direction)
  end
  
  def show
    @cast = Cast.find_by(company_id: params[:company_id])
    @workdays = @cast.workdays.order(:date)
    @new_workday = Workday.new(cast_id: @cast.id)
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end
  

  def edit
    @cast = Cast.find_by(company_id: params[:company_id])
  end
  
  def update
    @cast = Cast.find_by(company_id: params[:company_id])
  
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

  def sort_column
    %w[company_id family_name first_name].include?(params[:sort]) ? params[:sort] : "company_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  

  protected

  def current_ability
    @current_ability ||= Ability.new(current_cast)
  end


end
