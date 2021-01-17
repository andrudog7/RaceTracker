module StatisticsHelper

    def form_submit_text(statistic)
        if statistic.user_id == nil 
            "Add My Stats"
        else
            "Update My Stats"
        end
    end

end
