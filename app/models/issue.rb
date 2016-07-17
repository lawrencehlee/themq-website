class Issue < ActiveRecord::Base
	IMAGE_SUBDIRECTORY = 'general'

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
	  self.date.to_formatted_s(:long)
	end

	def get_relative_celeb_photo_path
		"#{self.get_abbreviated_issue_name}/#{IMAGE_SUBDIRECTORY}/#{self.celeb_photo}"
	end
end
