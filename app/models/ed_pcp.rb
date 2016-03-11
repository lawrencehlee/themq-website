class EdPcp < ActiveRecord::Base
	IMAGE_SUBDIRECTORY = 'ed_pcps'

	def get_ed_pcp_text
		filepath = File.join(
			Rails.root, 'app', 'assets', 'articles', self.text)
		File.read(filepath).encode("UTF-8", :invalid=>:replace)
	end

	def get_relative_author_image_path
		issue = Issue.find(self.issue_id)
		issue_string = "#{issue.volume_no}.#{issue.issue_no}"
		"#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.author_image}"
	end
end
