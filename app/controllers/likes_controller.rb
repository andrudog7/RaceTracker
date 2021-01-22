class LikesController < ApplicationController
    before_action :require_logged_in, only: [:create, :update]

    def create
        like = Like.new(:user_id => current_user.id, :statistic_id => params[:statistic_id], :like => true)
        like.save
        if params[:dashboard]
            redirect_to user_path(current_user)
        elsif params[:friend]
            redirect_to user_friendship_path(current_user, like.statistic.user)
        else
            redirect_to race_statistics_path(like.statistic.race)
        end
    end

    def update
        like = Like.find(params[:id])
        like.like == true ? like.like = false : like.like = true
        like.save 
        if params[:dashboard]
            redirect_to user_path(current_user)
        elsif params[:friend]
            redirect_to user_friendship_path(current_user, like.statistic.user)
        else
            redirect_to race_statistics_path(like.statistic.race)
        end
    end

    private 

    def like_params
        params.require(:like).permit(:id, :like)
    end
end
