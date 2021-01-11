class Statistic < ApplicationRecord
    belongs_to :user
    belongs_to :race
    has_many :likes

    scope :ordered, -> do
        order(finish_time: :asc)
      end
end
