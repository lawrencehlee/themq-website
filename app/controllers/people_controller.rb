class PeopleController < ApplicationController

  def index
    @editors = Person.get_editors_in_position_order

    @featured_editor = @editors.delete_at(rand(@editors.length))
    @featured_position = @featured_editor.position

    @first_editors = @editors[0..5] #gets the first six editors
    @last_editors = @editors[6..-1] #gets the rest of the editors

    @staff_members = Person.get_staff_members.sort_by { |member| member.get_last_name }
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
      @graphics << article.graphic
    end

    @graphics2 = @person.get_all_graphics_for_person
    @articles2 = Array.new()
    @graphics2.each do |graphic|
      @articles2 << graphic.article
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
end
