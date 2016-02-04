class Article < ActiveRecord::Base
  def get_article_text
    File.read(self.text)
  end
end
