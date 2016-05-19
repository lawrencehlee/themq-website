class Feature < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: :slugged
	FEATURE_SUBDIRECTORY = 'features'

	def should_generate_new_friendly_id?
		slug.blank? || self.name_changed?
	end


	def get_relative_feature_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{FEATURE_SUBDIRECTORY}/#{self.image}"
	end

	def get_feature_tags
		tags = Array.new()
		FeatureTag.where(feature_id: self.feature_id).each do |feature_tag|
			tags << Tag.find(feature_tag.tag_id)
		end
		tags
	end


	def self.get_top_feature
		issue = Issue.last
		issue_string = issue.get_abbreviated_issue_name
		filepath = File.join(
			Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "top feature"
				return f_lines[index + 1]
			end
		end
	end

	def self.get_column_features
		issue = Issue.last
		issue_string = issue.get_abbreviated_issue_name
		filepath = File.join(
			Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "column features"
				return f_lines[index + 1].split(",")
			end
		end
	end

	def self.get_more_features
		issue = Issue.last
		issue_string = issue.get_abbreviated_issue_name
		filepath = File.join(
			Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

		f_lines = File.open(filepath).read.split("\n")
		f_lines.each_with_index do |line, index|
			if line.include? "more features"
				return f_lines[index + 1].split(",")
			end
		end
	end

end
