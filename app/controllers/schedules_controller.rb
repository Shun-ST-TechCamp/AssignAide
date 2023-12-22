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
  
    # 休憩時間との競合をチェック
    if break_time_conflict?(@schedule)
      flash[:alert] = '選択された時間はキャストの休憩時間と競合しています。'
      render :new, status: :unprocessable_entity
      return
    end

    # 休憩時間に3人以上のキャストがいないかチェック
    if break_overlap_limit_exceeded?(@schedule)
      flash[:alert] = 'この休憩時間には既に3人のキャストが割り当てられています。'
      render :new, status: :unprocessable_entity
      return
    end
  
    if @schedule.save
      redirect_to positions_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @cast = @schedule.cast
  end

  def update
    if break_time_conflict?(@schedule)
      flash[:alert] = '選択された時間はキャストの休憩時間と競合しています。'
      render :edit, status: :unprocessable_entity
      return
    end
  
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
      start_time_str, end_time_str = TimeSlotConstants::TIME_SLOTS[@time_slot][1..2]
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
  
  def break_time_conflict?(schedule)
    # 休憩スケジュールを取得
    break_schedules = Schedule.where(workday_id: schedule.workday_id, position_id: break_position_id)
  
    break_schedules.any? do |break_schedule|
      # スケジュール時間が休憩時間と重なっているか確認
      schedule.start_time < break_schedule.end_time && schedule.end_time > break_schedule.start_time
    end
  end

  def break_position_id
    @break_position_id ||= Position.find_by(position_name: 'brake').id
  end

  def break_overlap_limit_exceeded?(schedule)
    # 休憩スケジュールを取得
    break_schedules = Schedule.where(workday_id: schedule.workday_id, position_id: break_position_id)
                              .where.not(id: schedule.id)

    overlapping_schedules = break_schedules.select do |break_schedule|
      schedule.start_time < break_schedule.end_time && schedule.end_time > break_schedule.start_time
    end

    overlapping_schedules.count >= 3
  end

end
