class TagsController < ApplicationController

	def index
		tag = Tag.find(params[:tag_id])
		if tag == nil
			tag = Tag.offest(rand(Tag.count)).first
		end
		@articles = tag.get_all_articles_with_tag
		@ed_pcps = tag.get_all_ed_pcps_with_tag
		@features = tag.get_all_features_with_tag
		@top_tens = tag.get_all_top_tens_with_tag
		@features = tag.get_all_features_with_tag
	end

	def show
		@tag = Tag.friendly.find(params[:id])
		@articles = @tag.get_all_articles_with_tag
		@ed_pcps = @tag.get_all_ed_pcps_with_tag
		@features = @tag.get_all_features_with_tag
		@top_tens = @tag.get_all_top_tens_with_tag
		@features = @tag.get_all_features_with_tag
	end

end
