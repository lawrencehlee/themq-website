class Person < ActiveRecord::Base
	def get_first_name
		self.name.split(' ').first
	end

	def get_more_content(limit, content_types, filter, excluded)
		more_content = Array.new
		this_author_filter = "person_id = #{self.person_id}"
		new_filter = [filter, this_author_filter].join(' AND ')

		content_types.each do |content_type|
			more_content += content_type.where(new_filter)
		end

		more_content.delete(excluded)
		more_content.sample(limit)
	end
end
