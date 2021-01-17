class Type < ApplicationRecord
    has_many :races
    has_many :statistics, through: :races
    validates :distance, numericality: { only_float: true }
    validates :name, uniqueness: true 
    validates :name, presence: true 

    scope :ordered, -> do
        joins(:statistic).merge(Statistic.ordered)
    end
end
