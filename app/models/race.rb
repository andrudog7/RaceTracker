class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type
    belongs_to :owner, :class_name => "User"
    validates_uniqueness_of :name, scope: :date

    def type_attributes=(attr)
        if attr["name"].present? && attr["distance"].present?
            self.type = Type.find_or_create_by(:name => attr["name"], :distance => attr["distance"])
        else
            self.type = Type.find(attr["id"])
            self.save 
        end
    end

    def statistic=(attr)
        if attr["finish_time"].present? && attr["finish_pace"].present? && attr["public"].present?
            if self.id != nil
                if attr["id"].present?
                    stat = Statistic.find(attr["id"])
                    stat.update(attr)
                else
                    stat = self.statistics.build(:finish_time => attr["finish_time"], :finish_pace => attr["finish_pace"], :public => attr["public"], :user_id => @current_user)
                    self.statistics << stat
                end
            end
        end
    end

    def date_format
        self.date.strftime("%B %d, %Y")
    end

    def display_name
        self.name.include?(self.date.strftime("%Y")) ? self.name : self.name + " " + self.date.strftime("%Y")
    end

    def self.search_races(params)
        if params[:date] == ""
            if Type.where("name ~* ?", params[:filter]) == []
                @races = self.where("location ~* ? or name ~* ?", "#{params[:filter]}", "#{params[:filter]}")
            else
                @races = Type.where("name ~* ?", params[:filter]).first.races
            end
        else
            if params[:filter] != ""
                if Type.where("name ~* ?", params[:filter]) == []
                    @races = self.where("(date = ?) and (location ~* ? or name ~* ?)", Date.parse(params[:date]), "#{params[:filter]}", "#{params[:filter]}") 
                else
                    @races = Type.where("name ~* ?", params[:filter]).first.races.where("date = ?", Date.parse(params[:date]))
                end
            elsif params[:filter] == ""
                @races = self.where("date = ?", Date.parse(params[:date]))
            else
                @races = Type.where("name ~* ?", params[:filter]).first.races
            end
        end
        @races
    end
end
