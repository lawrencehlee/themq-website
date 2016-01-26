class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end
    def index
    end
end
