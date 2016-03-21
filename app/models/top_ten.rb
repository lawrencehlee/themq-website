class TopTen < ActiveRecord::Base
	# Static method that gets all top tens from the specified issue
	def self.get_all_from_issue(issue)
		TopTen.where(issue_id: issue.issue_id)
	end

	# Static method that gets a random top ten from the specified issue
	def self.get_random_from_issue(issue)
		all_from_issue = TopTen.get_all_from_issue(issue)
		all_from_issue.offset(rand(all_from_issue.count)).first
	end

	# Gets the entries associated with this top ten
	def get_entries
		TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
	end
end
