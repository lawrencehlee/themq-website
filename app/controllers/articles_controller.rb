class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @article_text = @article.get_article_text
    end
    def index
    end

    private
    #def get_article_text
    #  "abcd"
    #end
end
