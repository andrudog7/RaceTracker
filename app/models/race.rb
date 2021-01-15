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
            self.save 
        end
    end

    def statistic=(attr)
        if attr["finish_time"].present? && attr["finish_pace"].present? && attr["public"].present?
            if self.id != nil
                if attr["id"].present?
                else
                s = Statistic.new(:finish_time => attr["finish_time"], :finish_pace => attr["finish_pace"], :public => attr["public"], :user_id => attr["user_id"])
                s.save
                self.statistics << s
                end
            end
        end
        self.save
    end

    def date_format
        self.date.strftime("%A %B %d, %Y")
    end

    def display_name
        self.name + " " + self.date.strftime("%Y")
    end
end
