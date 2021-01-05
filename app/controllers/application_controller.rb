class ApplicationController < ActionController::Base
    def home
    end

    helpers do 
        def current_user 
            session[:user_id] ||= session[:user_id]
        end

    end
end
