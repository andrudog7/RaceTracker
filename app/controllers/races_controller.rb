class RacesController < ApplicationController
    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def index
        if params[:filter].present? || params[:date].present?
            if params[:date] == ""
                if Type.where(:name => params[:filter]) == []
                    @races = Race.where("location ~* ? or name ~* ?", "#{params[:filter]}", "#{params[:filter]}")
                else
                    @races = Type.where(:name => params[:filter]).first.races
                end
            else
                if params[:filter] != ""
                    if Type.where(:name => params[:filter]) == []
                        @races = Race.where("(date = ?) and (location ~* ? or name ~* ?)", Date.parse(params[:date]), "#{params[:filter]}", "#{params[:filter]}") 
                    else
                        @races = Type.where(:name => "Marathon").first.races.where("date = ?", Date.parse(params[:date]))
                    end
                elsif params[:filter] == ""
                    @races = Race.where("date = ?", Date.parse(params[:date]))
                else
                    @races = Type.where(:name => params[:filter]).first.races
                end
            end
            if @races == []
                flash[:message] = "No races were found.  Create the race if it doesn't exist!"
                redirect_to user_path(current_user)
            else
            @races
            render 'users/show'
            end
        end
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
                statistic = Statistic.new(finish_time: race_params[:statistic][:finish_time], finish_pace: race_params[:statistic][:finish_pace], public: race_params[:statistic][:public], user_id: current_user.id)
                @race.statistics << statistic
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

    # def show 
    #     @race = Race.find(params[:id])
    # end

    def edit 
        @race = Race.find(params[:id])
        if @race.owner == current_user
            render 'edit'
        else
            redirect_to edit_statistic_path(@race.statistics.where(:user => current_user).first)
        end
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
        if race.valide?
            redirect_to race_statistics_path(race)
        else
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
