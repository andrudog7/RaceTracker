class UsersController < ApplicationController
    before_action :require_logged_in, only: [:show, :show_race_type]

    def new 
        @user = User.new 
    end

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            render new_user_path
        end
    end

    def show 
        @user = User.find(params[:id])
        if @user == current_user
            'show'
        else
            redirect_to '/'
        end
    end

    def show_race_type
    end

    private 

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :age, :password, :password_confirmation)
    end
end
