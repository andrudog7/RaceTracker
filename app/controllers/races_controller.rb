class RacesController < ApplicationController
    def index 
        @races = Race.public_races
    end
end
