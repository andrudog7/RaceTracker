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
        @logo = link_to image_tag("racetrackerlogo.jpg", id: "test", width:'110px'), '/'
        @signup = link_to "Sign Up", new_user_path
        @login = link_to "Login", '/login'
        if !logged_in?
            content_tag(:div, class: "menu_bar", style: "font-family='Segoe UI', Tahoma, Geneva, Verdana, sans-serif") do 
                content_tag(:ul) do
                    @button = button_tag 'All Races', class: "dropdown_btn"
                    @dashboard_elements = [@logo, @signup, @login, @button]
                    create_menu_buttons
                end
            end
        else
            content_tag(:div, class: "menu_bar") do 
                content_tag(:ul) do
                    @profile = link_to "My Profile", edit_user_path(current_user)
                    @dashboard = link_to "My Dashboard", user_path(current_user)
                    @button = button_tag 'My Races', class: "dropdown_btn"
                    @logout = link_to "Logout", '/logout', method: "post"
                    @all_users = link_to "Runners", users_path
                    @dashboard_elements = [@logo, @profile, @dashboard, @button, @all_users, @logout]
                    
                    create_menu_buttons
                end
            end
        end
    end

    def create_menu_buttons
        @dashboard_elements.each do |link|
            if link != @button
                concat content_tag(:li, link)
            elsif link == @button
                concat @button
                menu_race_types
            end
        end
    end

    def menu_race_types
        concat content_tag(:div, dropdown_menu_race_types, class: "dropdown_container") 
    end

    def dropdown_menu_race_types
        content_tag(:ul) do
            if logged_in?
            current_user.types.order(:distance).uniq.map do |type|
                concat content_tag(:li, type_links(type))
            end
            else
                Type.all.order(:distance).map do |type|
                    concat content_tag(:li, type_links(type))
                end
            end
        end
    end

    def type_links(type)
        if logged_in?
            link_to type.name, users_show_race_type_path(type) 
        else
            link_to type.name, "/types/#{type.slug}_races", method: 'get'  
        end   
    end
end
