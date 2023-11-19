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
      redirect_to schedules_path
    else
      @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
      render :new ,status: :unprocessable_entity
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @cast = @schedule.cast
    @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
  end

  def update
    @schedule = Schedule.find(params[:id])
  
    if @schedule.update(schedule_params.except(:cast_id))
      redirect_to schedules_path
    else
      @casts = Cast.all.map { |cast| [cast.full_name, cast.id] } 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path
  end

  def get_workdays_for_cast
    cast_id = params[:cast_id]
     workdays = Workday.where(cast_id: cast_id)
     render json: workdays
  end

  def for_cast_and_date
    @cast = Cast.find(params[:cast_id])
    @date = params[:date].to_date
    @schedules = Schedule.joins(:workday)
                         .where(cast_id: @cast.id, workdays: { date: @date })
                         .includes(:workday, :position)
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
