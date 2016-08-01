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
    @staff_members_right = @staff_members.slice(0, @staff_members.length/2)
    @staff_members_left = @staff_members.slice(@staff_members.length/2, @staff_members.length)
    @latest_issue = Issue.get_latest_issue
    @staff_photo = @latest_issue.get_abbreviated_issue_name + "/general/" + @latest_issue.staff_photo
    @staff_photo_caption = @latest_issue.staff_photo_caption
	end

	def show
		@person = Person.friendly.find(params[:id])
		@position_title = @person.get_title
		@articles = @person.get_all_articles_for_person
		@graphics = Array.new()
		@articles.each do |article|
			@graphics << article.get_graphic_for_article
		end

    @graphics2 = @person.get_all_graphics_for_person
    @articles2 = Array.new()
    @graphics2.each do |graphic|
      @articles2 << graphic.get_article_for_graphic
    end

    if @articles.count > @articles2.count
      @leading_articles = @articles
      @leading_graphics = @graphics
      @second_articles = @articles2
      @second_graphics = @graphics2
      @leading_articles = Kaminari.paginate_array(@articles).page(params[:page]).per(10)
      @first_column = "articles"
    else
      @leading_articles = @articles2
      @leading_graphics = @graphics2
      @second_articles = @articles
      @second_graphics = @graphics
      @leading_articles = Kaminari.paginate_array(@articles2).page(params[:page]).per(10)
      @first_column = "graphics"
    end
	end


	private

		def get_all_editors
			editors = Array.new()
			Person.order(:position_id).each do |person|
				if Position.find(person.position_id).title != "Staff Member" and person.current == "1"
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
			staff.sort_by { |member| member.split_full_name.last } 
    end
end
