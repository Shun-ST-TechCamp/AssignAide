class WorkdaysController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @workdays = Workday.joins(:cast).order(sort_column + " " + sort_direction)
  end

   def new
    @workday = Workday.new
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end

  def show
    @workday = Workday.find(params[:id])
    @schedules = @workday.schedules.includes(:position)
  end

  def create
    @workday = Workday.new(workday_params)
    if @workday.save
      redirect_to workdays_path, notice: 'スケジュールを入力しました。'
    else
      render :new
    end
  end

  def edit
    @workday = Workday.find(params[:id])
    @casts = Cast.all.map {|cast| [cast.full_name, cast.id]} 
  end



  def update
    @workday = Workday.find(params[:id])
    if @workday.update(workday_params)
      redirect_to workdays_path, notice: 'スケジュールを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @workday = Workday.find(params[:id])
    @workday.destroy
    redirect_to workdays_path, notice: 'スケジュールを削除しました'
  end

  def for_cast
    cast = Cast.find(params[:cast_id])
    workdays = cast.workdays
    render json: workdays
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
