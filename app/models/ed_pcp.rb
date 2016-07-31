require 'render_anywhere'

class EdPcp < ActiveRecord::Base
	extend FriendlyId
	include RenderAnywhere
	friendly_id :title, use: :slugged
	IMAGE_SUBDIRECTORY = 'ed_pcps'
	ARTICLE_SUBDIRECTORY = 'articles'

  searchable do
    text :headline, :author, :author_title
  end

	def should_generate_new_friendly_id?
		slug.blank? || self.title_changed?
	end

  def get_issue
    Issue.find(self.issue_id)
  end

	def get_ed_pcp_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.get_relative_article_path)
		File.read(filepath).encode("UTF-8", :invalid=>:replace)
	end

	def get_relative_article_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{ARTICLE_SUBDIRECTORY}/#{self.text}"
	end

	def get_relative_author_image_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.author_image}"
	end

	def self.group_point_counterpoint(point)
		retArray = Array.new
		counterpoint = EdPcp.find(point.crspnd_point_id)
		retArray << point
		retArray << counterpoint
		retArray
	end

	def get_ed_pcp_tags
		tags = Array.new
		EdPcpTag.where(ed_pcp_id: self.ed_pcp_id).each do |ed_pcp_tag|
			tags << Tag.find(ed_pcp_tag.tag_id)
		end
		tags
	end

	def self.get_top_editorials
		issue = Issue.get_latest_issue
		issue_string = issue.get_abbreviated_issue_name
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topEd_pcps.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "editorials"
				return f_lines[index + 1].split(",")
			end
		end
	end

	def self.get_top_pcps
		issue = Issue.get_latest_issue
		issue_string = issue.get_abbreviated_issue_name
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topEd_pcps.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "point_counterpoints"
				return f_lines[index + 1].split(",")
			end
		end
	end


	def get_ed_pcp_text_teaser
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

	def render_tag_view
		ed_pcp = self
		if self.counterpoint == 1
			ed_pcp = EdPcp.find(self.crspnd_point)
		end
		render partial: 'ed_pcps/tag_view', locals: {ed_pcp: ed_pcp}
	end

	def render_tag_show_view
		ed_pcp = self
		if self.counterpoint == 1
			ed_pcp = EdPcp.find(self.crspnd_point)
		end
		render partial: 'ed_pcps/tag_show_view', locals: {ed_pcp: ed_pcp}
	end

  def render_search_view
    render partial: 'ed_pcps/search_view', locals: {ed_pcp: self}
  end

	def get_tags
		tags = Array.new()
		EdPcpTag.where(ed_pcp_id: self.ed_pcp_id).each do |ed_pcp_tag|
			tags << Tag.find(ed_pcp_tag.tag_id)
		end
		tags
	end

	def get_related_content(limit, content_types, filter)
		related_content = Array.new
		content_types_clone = content_types.clone

		# Loop over all combinations of the tags, starting with matching
		# the most tags
		tags = get_tags
		tags.length.downto(1) do |num_tags|
			tag_combinations = tags.combination(num_tags)

			# Do EdPcp first to exclude self
			if content_types_clone.include?(EdPcp)
				content_types_clone.delete(EdPcp)
				prevent_duplicate_filter = "ed_pcp_id != #{self.ed_pcp_id}"
				new_filter = [filter, prevent_duplicate_filter].join(" AND ")
				tag_combinations.to_a.each do |tag_combination|
					related_content +=
						EdPcp.find_with_tags(tag_combination, new_filter)
				end
			end

			# Loop through each of the content pieces and query
			content_types_clone.each do |content_type|
				tag_combinations.to_a.each do |tag_combination|
					related_content +=
						content_type.find_with_tags(tag_combination, filter)
				end
			end
		end

		# Get limit random distinct items from the content
		related_content.uniq.sample(limit)
	end

	# self.find_with_tags(tags, filter)
	# Returns an array of ed/pcps that are filtered by filter
	# and that have all the tags specified in tags
	def self.find_with_tags(tags, filter)
		actual_results = Array.new
		potential_results = EdPcp.where(filter)

		# Loop over potential results
		potential_results.each do |result|
			result_valid = true

			# Check if they match all the provided tags
			tags.each do |tag|
				if EdPcpTag.where(
					{ed_pcp_id: result.ed_pcp_id, tag_id: tag.tag_id}).empty?
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

	def is_ed?
		return self.ed == "1"
	end

	def is_point?
		return self.point == "1"
	end

	def get_counterpoint
		EdPcp.where(crspnd_point_id: self.ed_pcp_id).first
	end

	def render_sidebar_view
		render partial: 'ed_pcps/sidebar_view', locals: {ed_pcp: self}
	end
end
