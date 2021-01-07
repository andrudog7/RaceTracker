module RacesHelper
    def public_races
        Race.all.where(:public => "true").order(:created_at).reverse_order
    end
end
