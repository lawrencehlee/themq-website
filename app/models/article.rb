class Article < ActiveRecord::Base
  def get_article_text
    File.read(self.text).encode("UTF-8", :invalid=>:replace)
  end
end
