class Statistic < ApplicationRecord
    belongs_to :user
    belongs_to :race
    has_many :likes, -> { where(likes: {like: true } ) }
    validates :finish_time, presence: true
    validates :finish_pace, presence: true

    scope :ordered, -> do
        order(finish_time: :asc)
    end

    def finish_time_format
        self.finish_time.strftime("%H:%M:%S")
    end

    def finish_pace_format
        self.finish_pace.strftime("%H:%M")
    end
end
