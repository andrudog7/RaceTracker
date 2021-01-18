class FriendshipsController < ApplicationController

    def create 
        friend = Friendship.new(:user_id => current_user.id)
        friend.friend_id = params[:user_id]
        friend.friendship = true 
        if friend.save
            redirect_to users_path
        else 
            '/'
        end
    end

    def update 
        friendship = Friendship.find(params[:id])
        friendship.friendship == true ? friendship.friendship = false : friendship.friendship = true
        friendship.save 
        redirect_to users_path
    end
end
