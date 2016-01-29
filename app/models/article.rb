class Article < ActiveRecord::Base
  def get_article_text
    # Fake comment
    self.text
  end
end
