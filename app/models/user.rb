class User < ApplicationRecord
    has_secure_password
    has_many :statistics
    has_many :races, through: :statistics
    has_many :likes
    # validate :email, presence :true, uniqueness :true
    # validate :first_name, presence :true
    # validate :last_name, presence :true
end
