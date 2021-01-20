module FriendshipsHelper
    def friend_statistics(friend)
        friend.statistics.where(:public => true).sort_by{|stat|stat.race.date}.reverse!
    end
end
