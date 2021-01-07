module ApplicationHelper
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

    def menu_bar
        if !logged_in?
            content_tag(:div, class: "menu_bar") do 
                content_tag(:ul) do
                    logo = link_to image_tag("racetrackerlogo.jpg", width:'110px'), '/'
                    signup = link_to "Sign Up", new_user_path
                    login = link_to "Login", '/login'
                    dashboard_elements = [logo, signup, login]
                    dashboard_elements.each do |link|
                        concat content_tag(:li, link)
                    end
                end
            end
        else
            content_tag(:div, class: "menu_bar") do 
                content_tag(:ul) do
                    logo = link_to image_tag("racetrackerlogo.jpg", width:'110px'), '/'
                    dashboard = link_to "My Dashboard", user_path(current_user)
                    logout = link_to "Logout", '/logout', method: "post"
                    dashboard_elements = [logo, dashboard, logout]
                    dashboard_elements.each do |link|
                        concat content_tag(:li, link)
                    end
                end
            end
        end
    end
end
