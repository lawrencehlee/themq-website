require 'render_anywhere'

class EdPcp < ActiveRecord::Base
	extend FriendlyId
	include RenderAnywhere
	friendly_id :title, use: :slugged
	IMAGE_SUBDIRECTORY = 'ed_pcps'
	ARTICLE_SUBDIRECTORY = 'articles'

	def should_generate_new_friendly_id?
		slug.blank? || self.title_changed?
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

	def get_editorials
		issue = Issue.last
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topEd_pcps.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "editorials"
				return f_lines[index + 1].split(",")
			end
		end
	end

	def get_pcps
		issue = Issue.last
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
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
		render partial: 'ed_pcps/tag_view', locals: {:ed_pcp => ed_pcp}
	end

	def render_tag_show_view
		ed_pcp = self
		if self.counterpoint == 1
			ed_pcp = EdPcp.find(self.crspnd_point)
		end
		render partial: 'ed_pcps/tag_show_view', locals: {:ed_pcp => ed_pcp}
	end
end
