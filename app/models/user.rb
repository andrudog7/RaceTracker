class User < ApplicationRecord
    has_secure_password
    has_many :statistics
    has_many :races, through: :statistics
    has_many :likes
    validates :email, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, confirmation: true 
end
