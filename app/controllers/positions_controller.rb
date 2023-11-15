class PositionsController < ApplicationController
  def index
    @positions = Position.all
  end

  def current
    @current_time = Time.current
    @schedule = Schedule.includes(:cast, :position).where(start_time: @current_time.beginning_of_hour..@current_time.end_of_hour)
  end

end
