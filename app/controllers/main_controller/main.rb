class MainController
  class Main
    def self.get_slideshow_content
      Article.find(Settings.main.slideshow_content)
    end

    def self.get_news_content
      Article.find(Settings.main.news_content)
    end

    def self.get_more_stories
      EdPcp.find(Settings.main.more_stories)
    end

    def self.get_features_content
      Feature.find(Settings.main.features_content)
    end
  end
end
