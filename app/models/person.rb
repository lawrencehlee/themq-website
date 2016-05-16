class Person < ActiveRecord::Base
	def get_first_name
		self.name.split(' ').first
	end

	def get_more_content(limit, content_types, filter)
		[Article.find(4)]
	end
end
