class RacesController < ApplicationController
    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def index
        if params[:filter].present? || params[:date].present?
            @races = Race.search_races(params)
            if @races == []
                flash[:race] = "No races were found.  Add a new race if it doesn't exist!"
                redirect_to user_path(current_user)
            else
                @races
                render 'users/show'
            end
        else 
            flash[:race] = "Please enter information to search by."
            redirect_to user_path(current_user)
        end
        # races = Race.all
        # render json: races.to_json
    end

    def new 
        @race = Race.new
        @race.build_type
        @race.statistics.build
    end

    def create
        @race = Race.find_by(:name => race_params[:name], :date => race_params[:date])
        if @race 
            flash[:message] = "This race has already been created!"
            redirect_to race_statistics_path(@race)
        else
            @race = Race.new(race_params)
            @race.owner = current_user
        end
        if @race.save 
            if @race.statistics == []
                @race.statistics << Statistic.new(finish_time: race_params[:statistic][:finish_time], finish_pace: race_params[:statistic][:finish_pace], public: race_params[:statistic][:public], user_id: current_user.id)
                if @race.save
                    redirect_to race_statistics_path(@race)
                else
                    redirect_to edit_race_statistic_path(@race)
                end
            end  
        else
            render 'new'
        end
    end

    def edit 
        @race = Race.find(params[:id])
        if @race.owner == current_user
            render 'edit'
        else
            redirect_to edit_statistic_path(@race.statistics.where(:user => current_user).first)
        end
    end

    def update
        @race = Race.find(params[:id])
        @race.update(race_params)
        if @race.statistics.last.user_id == nil
            @race.statistics.last.user = current_user
        end
        if @race.save
            redirect_to race_statistics_path(@race)
        else
            @race.errors[:statistics] << "cannot be blank."
            render 'edit'
        end
    end

    private 

    def race_params
        params.require(:race).permit(:name, :location, :date, :public, 
            type_attributes: [:id, :name, :distance],
            statistic: [:finish_time, :finish_pace, :public, :id]
        )
    end
end
