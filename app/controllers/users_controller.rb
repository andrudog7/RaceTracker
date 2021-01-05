class UsersController < ApplicationController

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
        if logged_in?
            redirect_to user_path(current_user)
        else
            redirect_to '/'
        end
    end

    def destroy 
        session.delete :user_id if session[:user_id]
        redirect_to '/'
    end

    

    private 

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :age, :password, :password_confirmation)
    end
end
