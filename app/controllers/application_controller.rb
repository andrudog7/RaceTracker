class ApplicationController < ActionController::Base
    def home
    end


    private 

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user 
    end

    def require_logged_in 
        if !logged_in?
            redirect_to '/'
        end
    end

end
