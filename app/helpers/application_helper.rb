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
                    logo = link_to image_tag("racetrackerlogo.jpg", id: "test", width:'110px'), '/'
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
                    button = button_tag 'My Races', class: "dropdown_btn"
                    logout = link_to "Logout", '/logout', method: "post"
                    dashboard_elements = [logo, dashboard, button, logout]
                    type_tags = []
                    current_user.types.each do |type|
                                    type_tags << (type.name)
                                end
                    dashboard_elements.each do |link|
                        if link != button
                            concat content_tag(:li, link)
                        elsif link == button
                            concat button
                            menu_race_types
                        end
                    end
                end
            end
        end
    end

    def menu_race_types
        concat content_tag(:div, dropdown_menu_race_types, class: "dropdown_container") 
    end

    def dropdown_menu_race_types
        content_tag(:ul) do
            current_user.types.map do |type|
                concat content_tag(:li, type_links(type))
            end
        end
    end

    def type_links(type)
        link_to type.name, type_path(type)        
    end
end
