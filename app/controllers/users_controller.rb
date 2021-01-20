class UsersController < ApplicationController
    before_action :require_logged_in, only: [:show, :show_race_type, :edit, :update]

    def new 
        @user = User.new 
    end

    def index 
        @users = User.where("id NOT IN(?)", current_user.id).order(:last_name)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def edit 
        @user = current_user
    end

    def update 
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to edit_user_path(@user)
        else
            render :edit 
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
        @type = Type.find(params[:format])
    end

    private 

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :age, :password, :password_confirmation)
    end
end
