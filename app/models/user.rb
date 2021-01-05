class User < ApplicationRecord
    has_secure_password
    has_many :statistics
    has_many :races, through: :statistics
    has_many :likes
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
        message: "only allows letters" }
    # validates :last_name, presence: true
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
end
