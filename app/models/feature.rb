require 'render_anywhere'

class Feature < ActiveRecord::Base
	extend FriendlyId
	include RenderAnywhere

	friendly_id :name, use: :slugged
	FEATURE_SUBDIRECTORY = 'features'

  searchable do
    text :title
  end

	def should_generate_new_friendly_id?
		slug.blank? || self.name_changed?
	end

  def get_issue
    Issue.find(self.issue_id)
  end

	def get_relative_feature_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{FEATURE_SUBDIRECTORY}/#{self.image}"
	end

	def get_tags
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

	def render_tag_view
		render partial: 'features/tag_view', locals: {:feature => self}
	end

	def render_tag_show_view
		render partial: 'features/tag_show_view', locals: {:feature => self}
	end

  def render_search_view
    render partial: 'features/search_view', locals: {feature: self}
  end

	def get_related_content(limit, content_types, filter)
		related_content = Array.new
		content_types_clone = content_types.clone

		# Loop over all combinations of the tags, starting with matching
		# the most tags
		tags = get_tags
		tags.length.downto(1) do |num_tags|
			tag_combinations = tags.combination(num_tags)

			# Do Feature first to exclude self
			if content_types_clone.include?(Feature)
				content_types_clone.delete(Feature)
				prevent_duplicate_filter = "feature_id != #{self.feature_id}"
				new_filter = [filter, prevent_duplicate_filter].join(" AND ")
				tag_combinations.to_a.each do |tag_combination|
					related_content +=
						Feature.find_with_tags(tag_combination, new_filter)
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
		related_content.uniq.sample(limit)
	end

	def self.find_with_tags(tags, filter)
		actual_results = Array.new
		potential_results = Feature.where(filter)

		# Loop over potential results
		potential_results.each do |result|
			result_valid = true

			# Check if they match all the provided tags
			tags.each do |tag|
				if FeatureTag.where(
					{feature_id: result.feature_id, tag_id: tag.tag_id}).empty?
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
end
