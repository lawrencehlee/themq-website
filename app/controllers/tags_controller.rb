class TagsController < ApplicationController

	def index
	end

	def show
		@tag = Tag.find(params[:id])
		@articles = @tag.get_all_articles_with_tag
	end

end
