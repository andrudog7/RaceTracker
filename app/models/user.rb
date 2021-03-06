class User < ApplicationRecord
    has_secure_password
    has_many :statistics
    has_many :races, through: :statistics
    has_many :likes, through: :statistics
    has_many :types, through: :races
    has_many :friendships
    has_many :friends, through: :friendships
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true, format: { with: /\A\D+\z/,
        message: "cannot contain numbers" }
    validates :last_name, presence: true
    validates :password, confirmation: true, :on => :create
    validates :password_confirmation, presence: true, :on => :create, unless: Proc.new { |a| a.UID.present?}
    validates :age, numericality: { less_than: 100, greater_than: 0, message: "must be a number between 1 and 99"}, unless: Proc.new { |a| a.UID.present?}

    def self.create_from_omniauth(auth)
        user = self.find_or_create_by(UID: auth['uid'], provider: auth['provider']) do |u|
            u.email = auth['info']['email']
            u.first_name = auth['info']['first_name']
            u.last_name = auth['info']['last_name']
            u.password = SecureRandom.hex(16)
        end
    end

    def total_race_type_distance(distance)
        count = self.types.where(:name => distance).count
        if self.types.where(:name => distance).first != nil
            distance = self.types.where(:name => distance).first.distance
        else
            distance = 0
        end
        count * distance
    end

    def friends 
        users = []
        self.friendships.where(:friendship => true).each do |friendship|
            users << User.find(friendship.friend_id)
        end 
        users
    end
end
