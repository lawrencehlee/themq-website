class ArticlesController < ApplicationController
	def show
		@article = Article.friendly.find(params[:id])
		@article_text = @article.get_article_text
		@graphic = Graphic.find(@article.graphic_id)
		@issue = Issue.find(@article.issue_id)
		@author = Person.find(@article.person_id)
		@author_position = Position.find(@author.position_id).title
		@graphic_designer = Person.find(@graphic.person_id)

		@tags = Array.new()
		@tags = @article.get_article_tags

		@related_content = @article.get_related_content
	end

	def index
		@top_story = Article.find(Article.first.get_top_story)
		@top_story_graphic = Graphic.find(@top_story.graphic_id)
		@top_story_issue = Issue.find(@top_story.issue_id)
		@top_story_person = Person.find(@top_story.person_id)

		@more_stories = Array.new()
		@more_stories_graphics = Array.new()
		Article.first.get_more_stories.each do |article_id|
			article = Article.find(article_id)
			@more_stories << article
			@more_stories_graphics << Graphic.find(article.graphic_id)
		end

	end

	def all
		@articles = Article.order('article_id DESC').page(params[:page]).per(10)
		@graphics = Graphic.order('article_id DESC').page(params[:page]).per(10)
	end

end
