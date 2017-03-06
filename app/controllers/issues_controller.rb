class IssuesController < ApplicationController

  def show
    @issue = Issue.friendly.find(params[:id])

    @top_articles = Issue.get_top_articles(@issue)
    @all_headlines = Article.get_all_from_issue(@issue)
    @article_headlines = @all_headlines.reject { |article| @top_articles.include? article }

    @ed_pcps = EdPcp.get_all_from_issue(@issue)

    @top_features = Issue.get_top_features(@issue).map { |id| Feature.find(id) }
    @feature_titles = Feature.get_all_from_issue(@issue).reject { |ft| @top_features.include? ft }
    @features = Feature.get_all_from_issue(@issue)

    @top_top_tens = Issue.get_top_top_tens(@issue).map { |id| TopTen.find(id) }
    @top_ten_titles = TopTen.get_all_from_issue(@issue).reject { |tt| @top_top_tens.include? tt }

    #misc info like self ads, skyboxes, staff photo, staff members, editors, eic note, booster club, etc.
    @self_ads = SelfAd.get_all_from_issue(@issue)   
    
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
