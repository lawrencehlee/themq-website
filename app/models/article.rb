class Article < ActiveRecord::Base
  def get_article_text
    self.text
  end
end
