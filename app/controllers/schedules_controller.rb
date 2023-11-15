class SchedulesController < ApplicationController

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end
  
end
