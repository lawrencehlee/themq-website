class FeaturesController < ApplicationController

	def index
	end

	def all
	end

	def show
		@feature = Feature.find(params[:id])
		@feature_path = "/barak/assets/" + @feature.get_relative_feature_path
		@width = @feature.width
		@height = @feature.height
	end
end
