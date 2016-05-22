class TagsController < ApplicationController

	def index
		@tag = Tag.find(params[:tag_id])
		if @tag == nil
			@tag = Tag.offest(rand(Tag.count)).first
		end

		@articles = @tag.get_all_articles_with_tag
		@ed_pcps = @tag.get_all_ed_pcps_with_tag
		@features = @tag.get_all_features_with_tag
		@top_tens = @tag.get_all_top_tens_with_tag
		@features = @tag.get_all_features_with_tag
	end

	def show
		#this is going to recieve a param of a piece of content as well as the tag id.
		#in the view, the piece of content is going to render a view for itself.
		#so this controller and view should be very bare
		@contentPiece = params[:content]
	end

end
