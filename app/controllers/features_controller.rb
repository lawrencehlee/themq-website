class FeaturesController < ApplicationController
	require 'fastimage'

	def index
	end

	def all
	end

	def show
		@feature = Feature.find(params[:id])
		@feature_path = '"' + @feature.get_relative_feature_path + '"'
		@width = FastImage.size(@feature_path)
	end
end
