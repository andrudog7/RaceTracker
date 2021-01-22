class StatisticsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update, :destroy]
  def new
    if params[:race_id]
      @race = Race.find(params[:race_id])
      @statistic = @race.statistics.build
    end
  end

  def create
    race = Race.find(params[:race_id])
    stat = race.statistics.build 
    stat.update(stat_params)
    stat.user = current_user
    stat.save
    redirect_to race_statistics_path(race)
  end

  def index
    @race = Race.find(params[:race_id])
  end

  def edit 
    @statistic = Statistic.find(params[:id])
    @race = @statistic.race
  end

  def update 
    @statistic = Statistic.find(params[:id])
    if @statistic.update(stat_params)
      redirect_to race_statistics_path(@statistic.race)
    else
      edit_statistic_path(@statistic)
    end
  end

  def destroy 
    stat = Statistic.find(params[:id])
    race = stat.race
    Like.where(:statistic_id => stat.id).each do |like|
      like.delete
    end
    stat.delete
    redirect_to race_statistics_path(race)
  end

  private 
  
  def stat_params
    params.require(:statistic).permit(:finish_time, :finish_pace, :public, :id)
  end
end
