class FeaturesController < ApplicationController

	def index
		@topFeature = Feature.find(Feature.get_top_feature)
		@columnFeatures = Array.new()
		Feature.get_column_features.each do |feat_id|
			@columnFeatures << Feature.find(feat_id)
		end
		@moreFeatures = Feature.get_more_features
		@moreFeatures = Array.new()
		Feature.get_more_features.each do |feat_id|
			@moreFeatures << Feature.find(feat_id)
		end
	end

	def all
	end

	def show
		@feature = Feature.friendly.find(params[:id])
		@feature_path = "/barak/assets/" + @feature.get_relative_feature_path
		@width = @feature.width
		@height = @feature.height
		@tags = Array.new()
		@tags = @feature.get_feature_tags

	end
end
