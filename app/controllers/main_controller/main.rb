class MainController
  class Main
    def self.get_slideshow_content
      Settings.main.slideshow_content.collect { |id| Article.find(id) }
    end

    def self.get_news_content
      Settings.main.news_content.collect { |id| Article.find(id) }
    end

    def self.get_more_stories
      Settings.main.more_stories.collect { |id| EdPcp.find(id) }
    end

    def self.get_features_content
      Feature.find(Settings.main.features_content)
    end
  end
end
