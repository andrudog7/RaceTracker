module UsersHelper
    
    def dashboard
    ["5k", "10k", "Half-Marathon", "Marathon"]
    end

    def user_races(type)
        if current_user.types.where(:name => type) != []
            current_user.types.where(:name => type).first.races.select{|race|race.users.include?(current_user)}
        else
            []
        end
    end

    def fastest_race(type)
        if user_races(type) != []
            user_races(type).includes(:finish_time).order('finish_time.sort_order')
        else 
            "Not Yet Available"
        end
    end

    def user_race_stats(race)
        race.statistics.where(:user == current_user).first
    end
end
