class Type < ApplicationRecord
    has_many :races
    has_many :statistics, through: :races
    validates :distance, numericality: { only_float: true }
    validates :name, uniqueness: true 
    validates :name, presence: true 

    scope :ordered, -> do
        joins(:statistic).merge(Statistic.ordered)
    end

    def self.type_races_by_date(type)
        self.where(:name => type).first.races.order(:date)
    end

    def slug 
        self.name.downcase.gsub("-", "_")
    end

    def self.find_by_slug(slug)
        name = slug.remove("_races").gsub("_", "-")
        self.where("name ~* ?", "#{name}").first.races.order(date: :desc)
    end
end
