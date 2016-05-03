class TagsController < ApplicationController

	def index
		@tags = Tag.all
	end

	def show
		@tag = Tag.find(params[:id])
		@articles = @tag.get_all_articles_with_tag
		@ed_pcps = @tag.get_all_ed_pcps_with_tag
		@features = @tag.get_all_features_with_tag
		@top_tens = @tag.get_all_top_tens_with_tag
	end

end
