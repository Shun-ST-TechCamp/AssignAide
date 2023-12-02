class WorkdaysController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @workdays = Workday.joins(:cast).order(sort_column + " " + sort_direction)
    @workdays_by_date = @workdays.group_by(&:date).transform_values do |workdays|
      sort_for_date = params[:sort_for_date]
      sort_column_for_date = params[:sort_column_for_date]
      sort_direction_for_date = params[:sort_direction_for_date]
  
      if sort_for_date.present? && sort_for_date == workdays.first.date.to_s
        sorted_workdays = if sort_column_for_date == 'casts.family_name'
                            workdays.sort_by { |workday| workday.cast.family_name }
                          else
                            workdays.sort_by { |workday| workday.send(sort_column_for_date) }
                          end
        sort_direction_for_date == 'desc' ? sorted_workdays.reverse : sorted_workdays
      else
        workdays
      end
    end
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
      @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
      render :new, status: :unprocessable_entity
    end
  end
  
  def create_for_cast_show
    Rails.logger.debug "Received params: #{params.inspect}"
    @workday = Workday.new(workday_params)
    if @workday.save
      redirect_to cast_path(company_id: @workday.cast.company_id), notice: '勤務日を追加しました。'
    else
      Rails.logger.debug @workday.errors.full_messages
      @cast = Cast.find_by(company_id: params[:cast_id])
      render 'casts/show', status: :unprocessable_entity
    end

  end

  def edit
    @workday = Workday.find(params[:id])
    @casts = Cast.all.map {|cast| [cast.full_name, cast.id]} 
  end



  def update
    @workday = Workday.find(params[:id])
    if @workday.update(workday_params.except(:cast_id))
      redirect_to workdays_path, notice: 'スケジュールを更新しました'
    else
      @casts = Cast.all.map { |cast| [cast.full_name, cast.id] }
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @workday = Workday.find(params[:id])
    @workday.destroy
    redirect_to workdays_path, notice: 'スケジュールを削除しました'
  end

  def destroy_by_date
    date = params[:date].to_date
    Workday.where(date: date).destroy_all
    redirect_to workdays_path, notice: "#{date} の勤務データを削除しました。"
  end

  def for_cast
    cast = Cast.find(params[:cast_id])
    workdays = cast.workdays
    render json: workdays
  end

  
  def for_cast_on_date
    cast_id = params[:cast_id]
    date = params[:date] || Date.today.to_s
  
    workdays = Workday.where(cast_id: cast_id, date: date)
    Rails.logger.debug "Workdays for cast #{cast_id} on #{date}: #{workdays.inspect}"
  
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
