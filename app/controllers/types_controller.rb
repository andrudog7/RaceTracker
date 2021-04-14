class TypesController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]

  def show
    if params[:id].include?("races")
      @races = Type.find_by_slug(params[:id])
      render 'show'
    else
      @type = Type.find(params[:id])
      if logged_in?
        @my_stats = @type.statistics.ordered.where(:user_id => current_user)
        if params[:sort] === "likes"
          @my_stats = @my_stats.sort{|a, b| b.likes.count <=> a.likes.count}
          render 'users/show_race_type'
        elsif params[:sort] === "finish_time"
          @my_stats = @my_stats.sort{|a, b| a.finish_time_format <=> b.finish_time_format}
          render 'users/show_race_type'
        elsif params[:sort] === "location"
          @my_stats = @my_stats.sort{|a, b| a.race.location <=> b.race.location}
          render 'users/show_race_type'
        elsif params[:sort] === "name"
          @my_stats = @my_stats.sort{|a, b| a.race.name <=> b.race.name}
          render 'users/show_race_type'
        else
          render 'users/show_race_type'
        end
      else
        render 'show'
      end
    end
  end

  def show_races
    @races = Type.find_by_slug(params[:slug_races])
    if logged_in?
      render users_show_race_type_path
    else
      render 'show_races'
    end
  end

  private 

  def type_params 
    params.require(:type).permit(:name, :distance)
  end
end
