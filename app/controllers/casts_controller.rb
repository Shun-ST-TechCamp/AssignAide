class CastsController < ApplicationController
  def index
    @casts = Cast.all
  end
end
