class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type
    belongs_to :owner, :class_name => "User"
    accepts_nested_attributes_for :type

    def type_attributes=(attributes)
        byebug
    end


end
