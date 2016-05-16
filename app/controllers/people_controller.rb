class PeopleController < ApplicationController

	def index
		@editors = get_all_editors

		@featured_editor = @editors.delete_at(rand(@editors.length))
		@featured_position = Position.find(@featured_editor.position_id)

		@first_editors = @editors[0..5] #gets the first six editors
		@last_editors = @editors[6..-1] #gets the rest of the editors

		@first_positions = Array.new()
		@last_positions = Array.new()

		@first_editors.each do |editor|
			@first_positions << Position.find(editor.position_id)
		end

		@last_editors.each do |editor|
			@last_positions << Position.find(editor.position_id)
		end

		@staff_members = get_all_staff_members
	end

	def show
		@person = Person.friendly.find(params[:id])
		@position = Position.find(@person.position_id)
		@articles = @person.get_all_articles_for_person
		@graphics = Array.new()
		@articles.each do |article|
			@graphics << article.get_graphic_for_article
		end
	end


	private

		def get_all_editors
			editors = Array.new()
			Person.order(:position_id).each do |person|
				if Position.find(person.position_id).title != "Staff Member"
					editors << person
				end
			end
			editors

		end

		def get_all_staff_members
			staff = Array.new()
			Person.all.each do |person|
				if Position.find(person.position_id).title == "Staff Member"
					staff << person
				end
			end
			staff
		end
end
