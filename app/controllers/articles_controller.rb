class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @article_text = @article.get_article_text
        @graphic = Graphic.find(@article.graphic_id)
        @issue = Issue.find(@article.issue_id)
        @author = Person.find(@article.person_id)
        @author_position = Position.find(@author.position_id).title
        @graphic_designer = Person.find(@graphic.person_id)

        @tags = Array.new()
        ArticleTag.where(article_id: params[:id]).each do |article_tag|
            @tags << Tag.find(article_tag.tag_id)
        end

    end

    def index
			@articles = Article.paginate(:page => params[:page], :per_page => 10).order(article_id: :desc)
			@graphics = Graphic.paginate(:page => params[:page], :per_page => 10).order(article_id: :desc)
    end

		def new
			#need to send in a top article and then next four or six articles

			@topArticle = Article.last
		end
end
