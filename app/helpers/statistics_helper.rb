module StatisticsHelper

    def form_submit_text(statistic)
        if statistic.user_id == nil 
            "Add My Stats"
        else
            "Update My Stats"
        end
    end

    def recent_friend_statistics
        Statistic.where(:user => current_user.friends).where(:public => true).order(created_at: :desc).limit(10)
    end
    
end
