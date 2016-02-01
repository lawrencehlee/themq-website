class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @article_text = @article.get_article_text
        @graphic = Graphic.find(@article.graphic_id)
    end
    def index
    end

    private
    #def get_article_text
    #  "abcd"
    #end
end
