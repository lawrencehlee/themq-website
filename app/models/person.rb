require 'render_anywhere'

class Person < ActiveRecord::Base
  extend FriendlyId
  include RenderAnywhere

  friendly_id :name, use: :slugged

  EDITORS_SUBDIRECTORY = 'editors'

  searchable do
    text :name
  end

  def get_position
    Position.find(self.position_id)
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end

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

  def get_first_name
    self.split_full_name.first
  end

  def get_last_name
    self.split_full_name.last
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

  # returns a person's position, or "former" + position name if they're alumni
  def get_title
    if self.current == "0"
      return "Former " + Position.find(self.position_id).title
    end
    Position.find(self.position_id).title
  end
  
  def render_search_view
    render partial: 'people/search_view', locals: {person: self}
  end

end
