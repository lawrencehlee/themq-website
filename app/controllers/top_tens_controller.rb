class TopTensController < ApplicationController

    def show
        @top_ten = TopTen.friendly.find(params[:id])
        @issue = Issue.find(@top_ten.issue_id)
        @top_ten_entries = @top_ten.get_entries

				@random_top_ten = TopTen.get_random_from_db(@top_ten.top_ten_id)
				@random_top_ten_entries = @random_top_ten.get_entries
    end

    def index
			@top_tens = TopTen.order('top_ten_id DESC').page(params[:page]).per(5)
    end

		def all
			@top_tens = TopTen.order('top_ten_id DESC').page(params[:page]).per(5)
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
    end
end
