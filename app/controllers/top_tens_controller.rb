class TopTensController < ApplicationController

    def show
        @top_ten = TopTen.find(params[:id])
        @issue = Issue.find(@top_ten.issue_id)
        @top_ten_entries = @top_ten.get_entries

				@random_top_ten = TopTen.get_random_from_db(@top_ten.top_ten_id)
				@random_top_ten_entries = @random_top_ten.get_entries
    end

    def index
    end

		def all
			@top_tens = TopTen.order('top_ten_id DESC').page(params[:page]).per(5)
		end
end
