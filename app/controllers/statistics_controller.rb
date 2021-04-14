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
    @public_stats = @race.public_statistics(current_user)

    if params[:sort]
      if params[:sort] === "name"
        @public_stats = @public_stats.sort{|a, b| a.user.last_name <=> b.user.last_name}
        @race
      elsif params[:sort] === "finish_time"
        @public_stats = @public_stats.sort{|a, b| a.finish_time_format <=> b.finish_time_format}
        @race
      elsif params[:sort] === "likes"
        @public_stats = @public_stats.sort{|a, b| b.likes.count <=> a.likes.count}
        @race
      end
    elsif params[:type_id]
      type = Type.find_by(:name => params[:type_id])
      @stats = type.statistics.where(:public => true)
      render 'statistics/type_statistics'
    else
      @race
      @public_stats
    end
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
