class FeaturesController < ApplicationController
	def index
	end

	def all
	end

	def show
		@feature = Feature.find(params[:id])
	end
end
