module UsersHelper
    
    def dashboard
    ["5k", "10k", "Half-Marathon", "Marathon"]
    end

    def user_race_count_of_type(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).races.count
        else
            "0"
        end
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
            user_races_of_type(type).statistics.ordered.first.finish_time_format
        else 
            "Not Yet Available"
        end
    end

    def fastest_race_finish_pace(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.first.finish_pace_format
        else 
            "Not Yet Available"
        end
    end

    def fastest_race_name(type)
        if user_races_of_type(type) != []
            user_races_of_type(type).statistics.ordered.first.race.name
        else 
            "Not Yet Available"
        end
    end

    def user_race_stats(race)
        race.statistics.where(:user == current_user).first
    end
end
