module LikesHelper
    def current_user_like_link(stat)
        if stat.likes.where(:user_id => current_user.id) != []
            if stat.likes.where(:user_id => current_user.id).first.like == true
                link_to "🌟", like_path(stat.likes.where(:user_id => current_user.id).first), class: "like_button", method: 'put'
            else
                link_to "☆", like_path(stat.likes.where(:user_id => current_user.id).first), class: "like_button", method: 'put'
            end
        else
           link_to "☆", statistic_likes_path(stat), class: "like_button", method: 'post'
        end
    end
end
