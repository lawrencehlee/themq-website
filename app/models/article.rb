class Article < ActiveRecord::Base
	extend FriendlyId
	friendly_id :text, use: :slugged
	ARTICLE_SUBDIRECTORY = 'articles'

  def get_article_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.get_relative_article_path)
    File.read(filepath).encode("UTF-8", :invalid=>:replace)
  end

	def get_attribution_line
		person = Person.find(self.person_id)
		issue = Issue.find(self.issue_id)
		"#{person.name} - #{issue.get_full_issue_name} - #{issue.get_human_readable_date}"
	end

	def get_article_text_teaser
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.get_relative_article_path)
		n = 1;
		open(filepath) do |f|
			lines = []
			n.times do
				line = f.gets || break
				lines << line
			end
			first_line = lines.first
			first_line.split(' ')[0, 25].join(' ') + "...";

		end
	end

	def get_relative_article_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{ARTICLE_SUBDIRECTORY}/#{self.text}"
	end

	def get_top_story
		issue = Issue.last
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topStories.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "top story"
				return f_lines[index + 1]
			end
		end
	end

	def get_more_stories
		issue = Issue.last
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topStories.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "more"
				return f_lines[index + 1].split(",")
			end
		end
	end

	def get_article_tags
		tags = Array.new()
		ArticleTag.where(article_id: self.article_id).each do |article_tag|
			tags << Tag.find(article_tag.tag_id)
		end
		tags
	end

end
