class SchedulesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :cast_all_map, only: [:new, :create, :edit, :update]
  before_action :set_schedule, only: [:edit, :update, :destroy]

  def index
    @schedules = Schedule.joins(:cast).order(sort_column + " " + sort_direction)
  end

  def new
    @schedule = Schedule.new
  end
  
  def create
    @schedule = Schedule.new(schedule_params)
    Rails.logger.debug "Creating Schedule with params: #{schedule_params.inspect}"
    if @schedule.save
      redirect_to positions_path
    else
      Rails.logger.debug "Failed to save schedule: #{@schedule.errors.full_messages}"
      render :new ,status: :unprocessable_entity
    end
  end

  def edit
    @cast = @schedule.cast
  end

  def update
    if @schedule.update(schedule_params.except(:cast_id))
      redirect_to schedules_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path
  end

  def get_workdays_for_cast
     cast_id = params[:cast_id]
     workdays = orkday.where(cast_id: cast_id)
     render json: workdays
  end

  def for_cast_and_date
    @cast = Cast.find(params[:cast_id])
    @date = params[:date].to_date
    @schedules = Schedule.joins(:workday)
                         .where(cast_id: @cast.id, workdays: { date: @date })
                         .includes(:workday, :position)
  end

  def new_position_schedule
    @date = params[:date].to_date
    @time_slot = params[:time_slot]
    @workday = Workday.find_by(date: @date)
    @position_id = params[:position_id]
    start_time_str, end_time_str = Schedule::TIME_SLOTS[@time_slot][1..2]
  
    base_date = @date.strftime("%Y-%m-%d")
    time_slot_start = Time.zone.parse("#{base_date} #{start_time_str}")
    time_slot_end = Time.zone.parse("#{base_date} #{end_time_str}")
  
   
    @available_casts = Cast.joins(:workdays)
                           .where(workdays: { date: @date })
                           .where("workdays.start_time <= ? AND workdays.end_time >= ?", time_slot_start, time_slot_end)
                           .distinct
        
    @schedule = Schedule.new
    unless @workday
      flash[:alert] = "指定された日付のワークデイが見つかりません。"
      redirect_to positions_path and return
    end
    @schedule.errors.full_messages
  end

  def remove_position_schedule
    schedule = Schedule.find(params[:id])
    if schedule.destroy
      flash[:notice] = "キャストをポジションから外しました。"
    else
      flash[:alert] = "キャストの削除に失敗しました。"
    end
    redirect_to positions_path
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

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def cast_all_map
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end
  

end
