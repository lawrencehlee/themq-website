class SelfAd < ActiveRecord::Base
	IMAGE_SUBDIRECTORY = 'self_ads'

	def get_relative_image_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.image}"
	end

	def self.get_all_from_issue(issue)
		SelfAd.where(issue_id: issue.issue_id)
	end

	# Static method that gets a random self ad from the specified issue
	def self.get_random_from_issue(issue)
		all_from_issue = SelfAd.get_all_from_issue(issue)
		all_from_issue.offset(rand(all_from_issue.count)).first
	end
end
