module StatisticsHelper

    def form_submit_text(statistic)
        if statistic.user_id == nil 
            "Add My Stats"
        else
            "Update My Stats"
        end
    end

    def current_user_like_link(stat)
        if stat.likes.where(:user_id => current_user.id) != []
            if stat.likes.where(:user_id => current_user.id).first.like == true
                link_to "🌟", like_path(stat.likes.where(:user_id => current_user.id).first), class: "button", method: 'put'
            else
                link_to "☆", like_path(stat.likes.where(:user_id => current_user.id).first), class: "button", method: 'put'
            end
        else
           link_to "☆", statistic_likes_path(stat), class: "button", method: 'post'
        end
    end
end
