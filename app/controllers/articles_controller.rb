class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @article_text = @article.get_article_text
        @graphic = Graphic.find(@article.graphic_id)
        @issue = Issue.find(@article.issue_id)
        @author = Person.find(@article.person_id)
        @author_position = Position.find(@author.position_id).title
        @graphic_designer = Person.find(@graphic.person_id)
    end

    def index
			@articles = Article.order(article_id: :desc)
    end
end
