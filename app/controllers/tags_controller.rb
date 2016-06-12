class TagsController < ApplicationController

	def index
    @tag_id = params[:tag_id]
    if @tag_id == nil
      @tag_id = Tag.offset(rand(Tag.count)).first
    end
		@tag = Tag.find(@tag_id)


		@articles = @tag.get_all_articles_with_tag
		@ed_pcps = @tag.get_all_ed_pcps_with_tag
		@features = @tag.get_all_features_with_tag
		@top_tens = @tag.get_all_top_tens_with_tag
		@features = @tag.get_all_features_with_tag
	end

	def show
    @tag_id = params[:tag_id]
    @content_type = params[:content_type]
	end

end
