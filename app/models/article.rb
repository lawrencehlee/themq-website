class Article < ActiveRecord::Base
  def get_article_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.text)
    File.read(filepath).encode("UTF-8", :invalid=>:replace)
  end

	def get_article_date
		issue = Issue.find(self.issue_id)
	end
end
