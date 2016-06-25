class Person < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	def should_generate_new_friendly_id?
		slug.blank? || self.name_changed?
	end


	EDITORS_SUBDIRECTORY = 'editors'

	def get_all_articles_for_person
		articles = Article.where(person_id: self.person_id)
		articles
	end

	def get_relative_image_path
		"#{EDITORS_SUBDIRECTORY}/#{self.image}"
	end

	def get_first_name
		self.name.gsub(/\s+/m, ' ').strip.split(" ").first
	end

end
