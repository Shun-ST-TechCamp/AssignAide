class PositionsController < ApplicationController
def index
  @date = params[:date] || Date.today
  @positions = Position.all
  workdays = Workday.where(date: @date)
  schedules = Schedule.includes(:position, :cast, :workday).where(workdays: { date: @date }).order(:start_time)
  @break_schedules = Schedule.where(workday: workdays, position: Position.find_by(position_name: 'brake'))

  @schedules_by_time_slot = Schedule::TIME_SLOTS.keys.each_with_object({}) do |time_slot, hash|
    time_slot_start, time_slot_end = Schedule::TIME_SLOTS[time_slot][1..2].map { |t| Time.zone.parse("#{@date} #{t}") }

    selected_schedules = schedules.select do |schedule|
      schedule_start = schedule.start_time.strftime("%H:%M")
      schedule_end = schedule.end_time.strftime("%H:%M")
      schedule_start == time_slot_start.strftime("%H:%M") && schedule_end == time_slot_end.strftime("%H:%M")
    end

    break_schedules_for_slot = @break_schedules.select do |break_schedule|
      break_schedule_start = break_schedule.start_time.strftime("%H:%M")
      break_schedule_end = break_schedule.end_time.strftime("%H:%M")
      break_schedule_start >= time_slot_start.strftime("%H:%M") && break_schedule_end <= time_slot_end.strftime("%H:%M")
    end.map do |break_schedule|
      break_schedule
    end
    
    hash[time_slot] = selected_schedules + break_schedules_for_slot
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

  def show_by_time_slot
    @date = params[:date] || Date.today
    @time_slot = params[:time_slot]
    @positions = Position.all

    start_of_slot = Time.zone.parse("#{@date} #{Schedule::TIME_SLOTS[@time_slot][1]}")
    end_of_slot = Time.zone.parse("#{@date} #{Schedule::TIME_SLOTS[@time_slot][2]}")

    @schedules = Schedule.includes(:cast, :position, :workday)
                         .where(workday: { date: @date })
                         .where('schedules.start_time >= ? AND schedules.end_time <= ?', start_of_time_slot, end_of_time_slot)
                         .order('schedules.start_time')
  end

    private

  def set_date_and_schedules
    @date ||= Date.today 
    schedules = Schedule.includes(:position, :cast, :workday)
                        .where(workdays: { date: @date })
                        .order(:start_time)

        @schedules_by_time_slot = Schedule::TIME_SLOTS.keys.each_with_object({}) do |time_slot, hash|
      start_time, end_time = Schedule::TIME_SLOTS[time_slot][1..2]
      selected_schedules = schedules.select do |schedule|
        schedule_start = schedule.start_time.strftime("%H:%M")
        schedule_end = schedule.end_time.strftime("%H:%M")
        schedule_start == start_time && schedule_end == end_time
      end
      hash[time_slot] = selected_schedules
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

  def start_of_time_slot
    Time.zone.parse("#{Date.today} #{Schedule::TIME_SLOTS[@time_slot][1]}")
  end

  def end_of_time_slot
    Time.zone.parse("#{Date.today} #{Schedule::TIME_SLOTS[@time_slot][2]}")
  end

end
