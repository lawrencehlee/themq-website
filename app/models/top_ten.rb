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

	# Static method that gets a random top ten from anywhere in the database
	# so long as it's not the top ten passed in.
	def self.get_random_from_db(current_top_ten_id)
		all_from_db = TopTen.where.not(top_ten_id: current_top_ten_id)
		all_from_db.offset(rand(all_from_db.count)).first
	end

	# Gets the entries associated with this top ten
	def get_entries
		TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
	end

end
