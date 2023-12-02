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
    
    if @schedule.save
      redirect_to positions_path
    else
      
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
    sort_by = params[:sort] || "start_time"
    direction = params[:direction] || "asc"
  
    @schedules = Schedule.joins(:workday, :position)
                         .where(cast_id: @cast.id, workdays: { date: @date })
                         .includes(:workday, :position)
                         .order(sort_by => direction)
  end

  def new_position_schedule
    @schedule = Schedule.new
    @date = params[:date].to_date
    @time_slot = params[:time_slot]
    @position_id = params[:position_id]
    @workday = Workday.find_by(date: @date)
    @available_workdays = Workday.where(date: @date)
  
    if @workday
      start_time_str, end_time_str = Schedule::TIME_SLOTS[@time_slot][1..2]
      base_date = @date.strftime("%Y-%m-%d")
      time_slot_start = Time.zone.parse("#{base_date} #{start_time_str}")
      time_slot_end = Time.zone.parse("#{base_date} #{end_time_str}")
  
      workday_ids = Workday.where(date: @date).pluck(:id)
      occupied_cast_ids = workday_ids.flat_map do |workday_id|
        Schedule.where(workday_id: workday_id)
                .where('(start_time <= ? AND end_time >= ?) OR (start_time >= ? AND start_time < ?) OR (end_time > ? AND end_time <= ?)', time_slot_start, time_slot_end, time_slot_start, time_slot_end, time_slot_start, time_slot_end)
                .pluck(:cast_id)
      end.uniq
  
  
      available_casts_for_time_slot = Cast.joins(:workdays)
                                          .where(workdays: { date: @date })
                                          .where("workdays.start_time <= ? AND workdays.end_time >= ?", time_slot_start, time_slot_end)
  
      # デバッグ：利用可能なキャストを確認
  
      @available_casts = available_casts_for_time_slot.where.not(id: occupied_cast_ids)
    else
      flash[:alert] = "指定された日付のワークデイが見つかりません。"
      redirect_to positions_path and return
    end
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
