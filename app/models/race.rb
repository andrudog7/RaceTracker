class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type

    def self.public_races
        self.all.where(:public => "true")
    end
end
