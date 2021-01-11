class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type
    belongs_to :owner, :class_name => "User"
    accepts_nested_attributes_for :type
    accepts_nested_attributes_for :statistics

    def public_statistics
        self.statistics.select{|stat|stat.public == true}
    end

end
