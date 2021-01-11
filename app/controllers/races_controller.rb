class RacesController < ApplicationController

    def new 
        @race = Race.new
        @race.build_type
        @race.statistics.build
    end

    def create
        if logged_in?
            @race = Race.find_or_create_by(:name => race_params[:name], :location => race_params[:location], :date => race_params[:date], :public => race_params[:public])
            @race.owner = current_user
            @race.type = Type.find_by(:id => race_params[:type_attributes][:id])
            statistic = Statistic.new(finish_time: race_params[:statistic][:finish_time], finish_pace: race_params[:statistic][:finish_pace], public: race_params[:statistic][:public], user_id: current_user.id)
            @race.statistics << statistic
            if @race.save
                redirect_to race_path(@race)
            else
                redirect_to new_race_path
            end
        else
            redirect_to '/'
        end
    end

    def show 
        @race = Race.find(params[:id])
    end

    private 

    def race_params
        params.require(:race).permit(:name, :location, :date, :public, 
            type_attributes: [:id, :name],
            statistic: [:finish_time, :finish_pace, :public]
        )
    end
end
