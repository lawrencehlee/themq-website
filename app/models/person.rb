class Person < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	def should_generate_new_friendly_id?
		slug.blank? || self.name_changed?
	end


	EDITORS_SUBDIRECTORY = 'editors'

	def get_all_articles_for_person
		Article.where(person_id: self.person_id)
	end

  def get_all_graphics_for_person
    Graphic.where(person_id: self.person_id)
  end

	def get_relative_image_path
		"#{EDITORS_SUBDIRECTORY}/#{self.image}"
	end

  def split_full_name
    self.name.gsub(/\s+/m, ' ').strip.split(" ")
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
