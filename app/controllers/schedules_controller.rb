class SchedulesController < ApplicationController
  helper_method :sort_column, :sort_direction


  def index
    @schedules = Schedule.joins(:cast).order(sort_column + " " + sort_direction)
  end

  def new
    @schedule = Schedule.new
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end
  
  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path, notice: 'スケジュールを入力しました。'
    else
      render :new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @casts = Cast.all.map {|cast| [cast.full_name, cast.id]} 
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to schedules_path, notice: 'スケジュールを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path, notice: 'スケジュールを削除しました'
  end


  private
  def schedule_params
    params.require(:schedule).permit(:cast_id, :position_id, :workday_id, :time_slot)
  end

  def sort_column
    allowed_columns = Schedule.column_names + ['casts.family_name']
    allowed_columns += ['position_id', 'workday_id']
    allowed_columns.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
