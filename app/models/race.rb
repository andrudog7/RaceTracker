class Race < ApplicationRecord
    has_many :statistics
    has_many :users, through: :statistics
    belongs_to :type
end
