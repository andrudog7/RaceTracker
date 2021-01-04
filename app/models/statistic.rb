class Statistic < ApplicationRecord
    belongs_to :user
    belongs_to :race
    has_many :likes
end
