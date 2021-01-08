class Type < ApplicationRecord
    has_many :races

    def self.public_races(type)
        self.all.where(:name => type).first.races.select{|race| race.public == true}
    end
end
