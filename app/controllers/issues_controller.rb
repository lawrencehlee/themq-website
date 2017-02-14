class IssuesController < ApplicationController

  def show
    @issue = Issue.friendly.find(params[:id])

    @top_articles = Issue.get_top_articles(@issue)
    @all_headlines = Article.get_all_from_issue(@issue)
    @article_headlines = @all_headlines.reject { |article| @top_articles.include? article }

    @top_ed_pcps = Issue.get_top_ed_pcps(@issue).map { |id| EdPcp.find(id) }
    @ed_pcp_headlines = EdPcp.get_all_from_issue(@issue).reject { |ed| @top_ed_pcps.include? ed }

    @top_features = Issue.get_top_features(@issue).map { |id| Feature.find(id) }
    @feature_titles = Feature.get_all_from_issue(@issue).reject { |ft| @top_features.include? ft }

    @top_top_tens = Issue.get_top_top_tens(@issue).map { |id| TopTen.find(id) }
    @top_ten_titles = TopTen.get_all_from_issue(@issue).reject { |tt| @top_top_tens.include? tt }
    
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
