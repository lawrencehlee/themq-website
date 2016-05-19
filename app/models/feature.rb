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

end
