class RacesController < ApplicationController
    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def new 
        @race = Race.new
        @race.build_type
        @race.statistics.build
    end

    def create
            @race = Race.find_by(:name => race_params[:name])
            if @race 
                redirect_to race_path(@race)
            else
            @race = Race.new(race_params)
            @race.owner = current_user
            if @race.save 
                if @race.statistics == []
                    statistic = Statistic.new(finish_time: race_params[:statistic][:finish_time], finish_pace: race_params[:statistic][:finish_pace], public: race_params[:statistic][:public], user_id: current_user.id)
                    @race.statistics << statistic
                    if @race.save
                        redirect_to race_path(@race)
                    else
                        render 'new'
                    end
                else
                    redirect_to race_path(@race) 
                end  
            else
                redirect_to '/'
            end
        end
    end

    def show 
        @race = Race.find(params[:id])
    end

    def edit 
        @race = Race.find(params[:id])
    end

    def update  
        race = Race.find(params[:id])
        if race_params[:statistic][:id].present? && race_params[:statistic][:id] != ""
            s = Statistic.find(race_params[:statistic][:id])
            s.update(race_params[:statistic])
        else
            s = Statistic.new(race_params[:statistic])
            s.user = current_user
            s.race_id = params[:id]
            s.save 
        end
        race.update(race_params)
        redirect_to race_path(race)
    end

    private 

    def race_params
        params.require(:race).permit(:name, :location, :date, :public, 
            type_attributes: [:id, :name, :distance],
            statistic: [:finish_time, :finish_pace, :public, :id]
        )
    end
end
