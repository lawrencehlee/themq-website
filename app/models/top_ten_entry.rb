class TopTenEntry < ActiveRecord::Base
	# Gets the full text of the top ten like so: 10. This is an entry
	def get_full_text
		"#{self.entry_no}. #{self.text}"
	end
end
