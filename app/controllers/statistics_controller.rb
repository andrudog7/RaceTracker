class StatisticsController < ApplicationController
  def new
    if params[:race_id]
      @race = Race.find(params[:race_id])
      @statistic = @race.statistics.build
    end
  end

  def create
    race = Race.find(params[:race_id])
    raise.params.inspect
  end

  def index
    @race = Race.find(params[:race_id])
  end
end
