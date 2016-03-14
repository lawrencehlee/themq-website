class Issue < ActiveRecord::Base
	def get_full_issue_name
		"Volume #{self.volume_no} Issue #{self.issue_no}"
	end

	def get_abbreviated_issue_name
		"#{self.volume_no}.#{self.issue_no}"
	end

	def get_human_readable_date
		date.strftime('%B %-d, %Y')
	end
end
