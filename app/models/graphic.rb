class Graphic < ActiveRecord::Base
	IMAGE_SUBDIRECTORY = 'graphics'

	def get_relative_image_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.image}"
	end
end
