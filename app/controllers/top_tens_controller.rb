class TopTensController < ApplicationController

    def show
        @top_ten = TopTen.find(params[:id])
        @issue = Issue.find(@top_ten.issue_id)
        @top_ten_entries = @top_ten.get_entries
    end

    def index
    end
end
