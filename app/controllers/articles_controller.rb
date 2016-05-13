class ArticlesController < ApplicationController
	def show
		@article = Article.friendly.find(params[:id])
		@article_text = @article.get_article_text
		@graphic = Graphic.find(@article.graphic_id)
		@issue = Issue.find(@article.issue_id)
		@author = Person.find(@article.person_id)
		@author_position = Position.find(@author.position_id).title
		@co_author, @co_author_position = @article.get_co_author_or_nil
		@graphic_designer = Person.find(@graphic.person_id)

		@tags = Array.new()
		@tags = @article.get_article_tags

		content_types = [Article]
		@related_content = @article.get_related_content(
			2,content_types,{ issue_id: @issue.issue_id })
	end

	def index
		@top_story = Article.find(Article.first.get_top_story)
		@top_story_graphic = Graphic.find(@top_story.graphic_id)
		@top_story_issue = Issue.find(@top_story.issue_id)
		@top_story_person = Person.find(@top_story.person_id)
		@top_story_co_author, @top_story_co_author_positon = @top_story.get_co_author_or_nil

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
