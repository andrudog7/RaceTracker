class Statistic < ApplicationRecord
    belongs_to :user
    belongs_to :race
    has_many :likes

    scope :ordered, -> do
        order(finish_time: :asc)
      end

    #   def finish_time
    #     if self.finish_time != nil
    #         return read_attribute(:finish_time).strftime("%H:%M:%S")
    #     else
    #         nil
    #     end
    #   end

    #   def finish_pace
    #     if self.finish_pace != nil
    #         return read_attribute(:finish_pace).strftime("%H:%M") 
    #     else 
    #         nil
    #     end
    #   end

    def finish_time_format
        self.finish_time.strftime("%H:%M:%S")
      end

      def finish_pace_format
        self.finish_pace.strftime("%H:%M")
      end
end
