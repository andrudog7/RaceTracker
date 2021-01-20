class FriendshipsController < ApplicationController
    before_action :require_logged_in, only: [:create, :update, :index]

    def index 
        @friends = current_user.friends.sort_by{|friend|friend.last_name}
    end

    def show 
        @friend = User.find(params[:id])
    end

    def create 
        friend = Friendship.new(:user_id => current_user.id, :friend_id => params[:user_id], :friendship => true)
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
