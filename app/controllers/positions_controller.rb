class PositionsController < ApplicationController
  def index
    @date = params[:date] || Date.today
    schedules = Schedule.includes(:position, :cast, :workday)
                        .where(workdays: { date: @date })
                        .order(:start_time)

    @schedules_by_time_slot = schedules.each_with_object({}) do |schedule, hash|
      time_slot = schedule.time_slot
      hash[time_slot] ||= []
      hash[time_slot] << schedule
    end
  end
  
  def current
    @current_time = Time.current
    @schedule = Schedule.includes(:cast, :position).where(start_time: @current_time.beginning_of_hour..@current_time.end_of_hour)
  end

 
    def show_tomorrow
      @date = Date.tomorrow
      @schedules = Schedule.includes(:cast, :position, :workday)
                           .where(workdays: { date: @date })
    end
  
    def show_day_after_tomorrow
      @date = Date.today + 2.days
      @schedules = Schedule.includes(:cast, :position, :workday)
                           .where(workdays: { date: @date })
    end
 
    private

  def set_date_and_schedules
    @date ||= Date.today # index では本日、show_tomorrow と show_day_after_tomorrow では上書きされる
    schedules = Schedule.includes(:position, :cast, :workday)
                        .where(workdays: { date: @date })
                        .order(:start_time)

    @schedules_by_time_slot = Schedule::TIME_SLOTS.keys.each_with_object({}) do |time_slot, hash|
      start_time, end_time = Schedule::TIME_SLOTS[time_slot][1..2]
      hash[time_slot] = schedules.select do |schedule|
        schedule.start_time.strftime("%H:%M") == start_time && schedule.end_time.strftime("%H:%M") == end_time
      end
    end
  end
end
