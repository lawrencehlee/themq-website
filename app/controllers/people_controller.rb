class PeopleController < ApplicationController

	def index
	end

	def show
		@person = Person.find(params[:id])
		@position = Position.find(@person.position_id)
		@articles = @person.get_all_articles_for_person
		@graphics = Array.new()
		@articles.each do |article|
			@graphics << article.get_graphic_for_article
		end
	end

end
