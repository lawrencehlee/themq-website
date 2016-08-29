class TopTensController < ApplicationController

    def show
        @top_ten = TopTen.friendly.find(params[:id])
        @issue = Issue.find(@top_ten.issue_id)
        @top_ten_entries = @top_ten.get_entries

        @current_issue = Issue.get_latest_issue
        @random_top_ten = nil
        @random_self_ad = SelfAd.get_random
        @brief = Article.get_random_brief_from_issue(@current_issue)
    end

    def index
        @top_tens = TopTen.order('top_ten_id DESC').page(params[:page]).per(5)

        @current_issue = Issue.get_latest_issue
        @top_ten_randomizer = nil
        @random_self_ad = SelfAd.get_random
        @brief = Article.get_random_brief_from_issue(@current_issue)
    end

    def random
        @top_ten = TopTen.offset(rand(TopTen.count)).first
        i = 1
        @entries = Array.new()
        while i < (@top_ten.no_of_entries + 1) do
            @entries << TopTenEntry.where(entry_no: i).sample
            i = i + 1
        end
        @entries = @entries.reverse

        @random_top_ten = nil
        @random_self_ad = SelfAd.get_random
        @brief = nil

    end
end
