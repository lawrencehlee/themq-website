class Issue < ActiveRecord::Base
	# Static method that gets the latest issue by date
	def self.get_latest_issue
		Issue.order("date DESC").first
	end

	# Returns the full issue name in the form Volume x Issue y
	def get_full_issue_name
		"Volume #{self.volume_no} Issue #{self.issue_no}"
	end

	# Returns the abbreviated issue name in the form x.y
	def get_abbreviated_issue_name
		"#{self.volume_no}.#{self.issue_no}"
	end

	# Returns the issue date in the form January 5, 2025
	def get_human_readable_date
		date.strftime('%B %-d, %Y')
	end
end
