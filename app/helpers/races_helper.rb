module RacesHelper
    def public_races
        Race.all.where(:public => "true")
    end
end
