module FriendshipsHelper
    def friend_statistics(friend)
        friend.statistics.where(:public => true).sort_by{|stat|stat.race.date}.reverse!
    end

    def friend_link_text(user)
        if current_user.friendships.where(:friend_id => user.id).first.friendship == true 
            "Unfollow"
        else
            "Follow"
        end
    end

    def friend_link(user)
        if current_user.friendships.where(:friend_id => user.id) != []
            link_to friend_link_text(user), friendship_path(current_user.friendships.where(:friend_id => user.id).first), method: 'put'
        else
            link_to "Follow", user_friendships_path(user), method: 'post'
        end
    end
end
