class PositionsController < ApplicationController
  def index
    @date = params[:date] || Date.today
    @positions = Position.all
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
  
  def current
    @current_time = Time.current
    @schedule = Schedule.includes(:cast, :position).where(start_time: @current_time.beginning_of_hour..@current_time.end_of_hour)
  end

 
  def show_tomorrow
    @date = Date.tomorrow
    @positions = Position.all
    schedules = Schedule.includes(:cast, :position, :workday)
                        .where(workdays: { date: @date })
                        .order(:start_time)

    @schedules_by_time_slot = build_schedules_by_time_slot(schedules)
  end
  
  def show_day_after_tomorrow
    @date = Date.today + 2.days
    @positions = Position.all
    schedules = Schedule.includes(:cast, :position, :workday)
                        .where(workdays: { date: @date })
                        .order(:start_time)
  
    @schedules_by_time_slot = build_schedules_by_time_slot(schedules)
  end

    private

  def set_date_and_schedules
    @date ||= Date.today 
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

  def build_schedules_by_time_slot(schedules)
    Schedule::TIME_SLOTS.keys.each_with_object({}) do |time_slot, hash|
      start_time, end_time = Schedule::TIME_SLOTS[time_slot][1..2]
      hash[time_slot] = schedules.select do |schedule|
        schedule.start_time.strftime("%H:%M") == start_time && schedule.end_time.strftime("%H:%M") == end_time
      end
    end
  end
end
