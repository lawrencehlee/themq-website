class FeaturesController < ApplicationController
	require 'fastimage'

	def index
	end

	def all
	end

	def show
		@feature = Feature.find(params[:id])
		@feature_path = request.protocol + request.host_with_port + "/assets/" + @feature.get_relative_feature_path
		@width = 1024
		@height = 768
	end
end
