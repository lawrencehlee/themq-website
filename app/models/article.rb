require 'render_anywhere'

class Article < ActiveRecord::Base
	extend FriendlyId
	include RenderAnywhere

	friendly_id :title, use: :slugged

	ARTICLE_SUBDIRECTORY = 'articles'

	def is_brief?
		brief == 1
	end

	def should_generate_new_friendly_id?
		slug.blank? || self.title_changed?
	end

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

	def get_article_text_teaser(words)
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
			first_line.split(' ')[0, words].join(' ') + "...";

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

	def self.get_all_briefs_from_issue(issue)
		Article.where(issue_id: issue.issue_id, brief: 1)
	end

	def self.get_random_brief_from_issue(issue)
		all_from_issue = Article.get_all_briefs_from_issue(issue)
		all_from_issue.offset(rand(all_from_issue.count)).first
	end

	def render_sidebar_view
		render :partial => 'articles/sidebar_view', :locals => {:article => self}
	end

	# This method is a bit complex so I guess it deserves a header
	# get_related_content(limit, content_types, filter)
	# Returns an array of content models that are "related" by tag to
	# this article. It will find up to limit results that are of the
	# classes specified in the content_types parameter.
	# The filter parameter is used for any other miscellaneous
	# criteria in querying for models.
	def get_related_content(limit, content_types, filter)
		related_content = Array.new

		# Loop over all combinations of the tags, starting with matching
		# the most tags
		tags = get_article_tags
		tags.length.downto(1) do |num_tags|
			tag_combinations = tags.combination(num_tags)

			# Do Article first to exclude self
			if content_types.include?(Article)
				content_types.delete(Article)
				prevent_duplicate_filter = "article_id != #{self.article_id}"
				new_filter = [filter, prevent_duplicate_filter].join(" AND ")
				tag_combinations.to_a.each do |tag_combination|
					related_content +=
						Article.find_with_tags(tag_combination, new_filter)
				end
			end

			# Loop through each of the content pieces and query
			content_types.each do |content_type|
				tag_combinations.to_a.each do |tag_combination|
					related_content +=
						content_type.find_with_tags(tag_combination, filter)
				end
			end
		end

		# Get limit random items from the content
		related_content.sample(limit)
	end

	# This static method also deserves some explaining and maybe a header
	# self.find_with_tags(tags, filter)
	# Returns an array of articles that are filtered by filter
	# and that have all the tags specified in tags
	def self.find_with_tags(tags, filter)
		actual_results = Array.new
		potential_results = Article.where(filter)

		# Loop over potential results
		potential_results.each do |result|
			result_valid = true

			# Check if they match all the provided tags
			tags.each do |tag|
				if ArticleTag.where(
					{article_id: result.article_id, tag_id: tag.tag_id}).empty?
					result_valid = false
					break
				end
			end

			# If so, add them to the return array
			if result_valid
				actual_results << result
			end
		end
		actual_results
	end

	def get_co_author_or_nil
		if self.co_author
			co_author = Person.find(self.co_author)
			return co_author, Position.find(co_author.position_id).title
		end

		return nil, nil
	end
end
