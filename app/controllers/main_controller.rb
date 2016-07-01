class MainController < ApplicationController
  def index
		@current_issue = Issue.get_latest_issue

		# TODO: In the future, we're going to hand-select the featured
		# pieces in the slideshow
		@featured_content = Array.new
		@featured_content << Article.find(1)
		@featured_content << Article.find(2)

		@news_articles = Array.new
		@news_articles << Article.find(13)
		@news_articles << Article.find(14)

		@point = EdPcp.where(point: 1).first
		@counterpoint = EdPcp.where(crspnd_point_id: @point.ed_pcp_id).first

		@random_top_ten = TopTen.get_random_from_issue(@current_issue)
		@random_self_ad = SelfAd.get_random_from_issue(@current_issue)

		@brief = Article.get_random_brief_from_issue(@current_issue)
  end
end
