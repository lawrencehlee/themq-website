class IssuesController < ApplicationController

  def show
    @issue = Issue.friendly.find(params[:id])
    @top_articles = Issue.get_top_articles(@issue).map { |id| Article.find(id) }
    @all_headlines = Article.get_all_articles_from_issue(@issue)
    @article_headlines = @all_headlines.reject { |article| @top_articles.include? article }
  end

  def index
    @issues = Issue.order_by_date(Issue.all, true)
    @articles = Article.all
    @issues = Issue.all
  end

  def all
    @issues = Issue.order_by_date(Issue.all, true)
    @issues = Issue.all
  end
end
