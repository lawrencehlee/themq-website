require 'render_anywhere'

class TopTen < ActiveRecord::Base

	include RenderAnywhere
	extend FriendlyId
	friendly_id :name, use: :slugged

	def should_generate_new_friendly_id?
		slug.blank? || self.name_changed?
	end

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

	def render_tag_view
		render partial: 'top_tens/tag_view', locals: {:top_ten => self}
	end

  # Gets top ten entries 10 through 7.
	def get_top_ten_entries_teaser
		number_of_entries = 4
		TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc").first(number_of_entries)
		#TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
	end

	def get_top_ten_tags
		tags = Array.new()
		TopTenTag.where(top_ten_id: self.top_ten_id).each do |top_ten_tag|
			tags << Tag.find(top_ten_tag.tag_id)
		end
		tags
	end

end
