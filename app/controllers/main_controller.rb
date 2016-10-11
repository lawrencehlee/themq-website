class MainController < ApplicationController
  def index
    @current_issue = Issue.get_latest_issue

    @featured_content = Issue.get_slideshow_content.map { |id| Article.find(id) }

    @news_articles = Issue.get_news_content.map { |id| Article.find(id) }

    @more_stories = Issue.get_more_stories.map { |id| EdPcp.find(id) }

    @features_content = Issue.get_features_content.map { |id| Feature.find(id) }

    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random_from_issue(@current_issue)

    @brief = Article.get_random_brief_from_issue(@current_issue)

    @skybox = Skybox.get_random_from_issue(@current_issue)
  end
end
