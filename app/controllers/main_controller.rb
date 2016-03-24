class MainController < ApplicationController
  def index
		@current_issue = Issue.get_latest_issue

		# TODO: In the future, we're going to hand-select the featured
		# pieces in the slideshow
		@featured_content = Array.new
		@featured_content << Article.find(1)
		@featured_content << Article.find(2)

		@more_shit_1 = Article.find(1)
		@more_shit_2 = Article.find(2)

		@random_top_ten = TopTen.get_random_from_issue(@current_issue)
  end
end
