class User < ApplicationRecord
    has_secure_password
    has_many :statistics
    has_many :races, through: :statistics
    has_many :likes
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true, format: { with: /\A\D+\z/,
        message: "cannot contain numbers" }
    # validates :last_name, presence: true
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    validates :age, numericality: { less_than: 100, greater_than: 0, message: "must be a number between 1 and 99"}
end
