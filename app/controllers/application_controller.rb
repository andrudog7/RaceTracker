class ApplicationController < ActionController::Base
    def home
    end

    def login
        if !logged_in?
            render :login
        else
            redirect_to user_path(current_user)
        end
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user 
    end
end
