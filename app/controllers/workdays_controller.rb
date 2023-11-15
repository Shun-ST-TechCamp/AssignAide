class WorkdaysController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @workdays = Workday.joins(:cast).order(sort_column + " " + sort_direction)
  end

  def new
    @workday = Workday.new
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end

  def create
    @workday = Workday.new(workday_params)
    if @workday.save
      redirect_to workdays_path, notice: 'スケジュールを入力しました。'
    else
      render :new
    end
  end

  private

  def workday_params
    params.require(:workday).permit(:cast_id, :date, :start_time, :end_time)
  end

  def sort_column
    allowed_columns = Workday.column_names + ['casts.family_name']
    allowed_columns.include?(params[:sort]) ? params[:sort] : "date"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
