class Feature < ActiveRecord::Base
	FEATURE_SUBDIRECTORY = 'features'

	def get_relative_feature_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{FEATURE_SUBDIRECTORY}/#{self.image}"
	end

end
