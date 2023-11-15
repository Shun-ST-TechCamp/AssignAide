class WorkdaysController < ApplicationController

  def index
    @workdays = Workday.all
  end
  
end
