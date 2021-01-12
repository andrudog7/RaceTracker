class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type
    belongs_to :owner, :class_name => "User"
    #accepts_nested_attributes_for :type
    #accepts_nested_attributes_for :statistics
    validates :name, uniqueness: true 

    def type_attributes=(attr)
        if attr["name"].present? && attr["distance"].present?
            self.type = Type.find_or_create_by(attr)
        else
            self.type = Type.find(attr["id"]) 
        end
    end

    def statistic=(attr)
        if attr["finish_time"].present? && attr["finish_pace"].present? && attr["public"].present? 
            s = Statistic.new(:finish_time => attr["finish_time"], :finish_pace => attr["finish_pace"], :public => attr["public"])
            if self.id != nil
                self.statistics << s
            end
        end
    end

    def date_format
        self.date.strftime("%A %B %d, %Y")
    end
end
