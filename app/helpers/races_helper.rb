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
        race.users.where(:id => current_user.id).first.statistics.first
    end
end
