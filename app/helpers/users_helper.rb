module UsersHelper
    
    def dashboard
    ["5k", "10k", "Half-Marathon", "Marathon"]
    end

    def find_type(type)
        Type.find_by(:name => type)
    end

    def user_race_count_of_type(type)
        current_user.races.where(:type => user_races_of_type(type)).count
    end

    def user_races_of_type(type)
        if current_user.types.where(:name => type) != []
            current_user.types.where(:name => type).first
        else
            []
        end
    end

    def fastest_race_finish_time(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.where(:user => current_user).first.finish_time_format
        else 
            "Not Yet Available"
        end
    end

    def fastest_race_finish_pace(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.where(:user => current_user).first.finish_pace_format
        else 
            "Not Yet Available"
        end
    end

    def fastest_race_name(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.where(:user => current_user).first.race.name
        else 
            "Not Yet Available"
        end
    end

    def fastest_race_year(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.where(:user => current_user).first.race.date.strftime("%Y")
        else 
            ""
        end
    end



    
end
