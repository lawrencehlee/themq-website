class MainController < ApplicationController
  def index
    @current_issue = Issue.get_latest_issue

    @featured_content = Main.get_slideshow_content
    @news_articles = Main.get_news_content
    @more_stories = Main.get_more_stories
    @features_content = Main.get_features_content

    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random_from_issue(@current_issue)
    @brief = Article.get_random_brief_from_issue(@current_issue)
    @skybox = Skybox.get_random_from_issue(@current_issue)
  end
end
