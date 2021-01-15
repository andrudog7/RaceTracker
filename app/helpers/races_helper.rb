module RacesHelper
    def public_races
        Race.all.where(:public => "true").order(:created_at).reverse_order.limit(6)
    end

    def public_statistics(race)
        if race.users.include?(current_user)
            if race.statistics.where(:user => current_user).first.public != true 
                race.statistics.ordered.where(:public => true).or(race.statistics.where(:user => current_user))
            else 
                race.statistics.ordered.where(:public => true)  
            end
        else
            race.statistics.ordered.where(:public => true)  
        end
    end

    def current_user_stats(race)
        race.statistics.where(:user_id => current_user.id).first
    end

    def current_user_stats_for_form(race)
        if race.users != [] && race.users.include?(current_user)
            current_user_stats(race)
        else
            race.statistics.build 
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
            "Edit Race"
        elsif race.users.include?(current_user)
            "Update Your Stats"
        else
            "Add Your Stats"
        end
    end

    def submit_button_text(race)
        if race.id == nil
            "Create Race"
        else
            "Update Race"
        end
    end

    def form_url(race)
        if @race.owner == nil 
            new_race_path(race)
        else
            race_path(race)
        end
    end

    def form_method(race)
        if @race.owner == nil 
            'get'
        else 
            'put'
        end
    end
end
