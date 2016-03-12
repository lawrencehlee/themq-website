class MainController < ApplicationController
  def index
		# TODO: In the future, we're going to hand-select the featured
		# pieces in the slideshow
		@featured_content = Array.new
		@featured_content << Article.find(1)
		@featured_content << Article.find(2)

		@more_shit_1 = Article.find(1)
		@more_shit_2 = Article.find(2)
  end
end
