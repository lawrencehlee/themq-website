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
    #here we want to show all the features clumped by issue.
    #That means having an array of length num_of_issues,
    #with each element in that array being an array of the features in the issue
    @allFeatures = Array.new()
    Issue.order("volume_no, issue_no").each do |issue|
      feature_set = Feature.where(issue_id: issue.issue_id)
      if feature_set != nil
        @allFeatures << Feature.where(issue_id: issue.issue_id)
      end
    end
    @feature_sets = @allFeatures[1..-1].reverse
	end

	def show
		@feature = Feature.friendly.find(params[:id])
		@feature_path = "/assets/" + @feature.get_relative_feature_path
		@width = @feature.width
		@height = @feature.height
		@tags = Array.new()
		@tags = @feature.get_feature_tags

	end
end
