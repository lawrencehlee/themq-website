class Article < ActiveRecord::Base
  def get_article_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.text)
    File.read(filepath).encode("UTF-8", :invalid=>:replace)
  end

	def get_attribution_line
		person = Person.find(self.person_id)
		issue = Issue.find(self.issue_id)
		"#{person.name} - #{issue.get_full_issue_name} - #{issue.get_human_readable_date}"
	end
end
