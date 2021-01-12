module RacesHelper
    def public_races
        Race.all.where(:public => "true").order(:created_at).reverse_order.limit(6)
    end

    def public_statistics(race)
        if race.users.include?(current_user) && race.statistics.where(:user => current_user).first.public != true
           statistics = [] 
           statistics << race.statistics.where(:user => current_user).first
           race.statistics.select{|stat|stat.public == true}.each do |stat|
            statistics << stat
           end
           statistics
        else
            race.statistics.select{|stat|stat.public == true}
        end
    end

    def current_user_stats(race)
        race.statistics.where(:user_id => current_user.id).first
    end

    def current_user_stats_for_form(race)
        if race.users != [] && race.users.include?(current_user)
            current_user_stats(race)
        else
            race.statistics.first 
        end
    end

    def finish_time_value(race)
        if current_user_stats_for_form(race).id != nil 
            current_user_stats_for_form(race).finish_time_format
        end
    end

    def finish_pace_value(race)
        if current_user_stats_for_form(race).id != nil 
            current_user_stats_for_form(race).finish_pace_format
        end
    end

    def edit_race_button_text(race)
        if race.owner == current_user
            "Update Race"
        else
            "Add Your Stats"
        end
    end
end
