class LikesController < ApplicationController
    before_action :require_logged_in, only: [:create, :update]

    def create
        like = Like.new(:user_id => current_user.id)
        like.statistic_id = params[:statistic_id]
        like.like = true 
        like.save
        redirect_to race_statistics_path(like.statistic.race)
    end

    def update
        like = Like.find(params[:id])
        like.like == true ? like.like = false : like.like = true
        like.save 
        redirect_to race_statistics_path(like.statistic.race)
    end

    private 

    def like_params
        params.require(:like).permit(:id, :like)
    end
end
