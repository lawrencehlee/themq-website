require 'render_anywhere'

class Graphic < ActiveRecord::Base
  include RenderAnywhere

  IMAGE_SUBDIRECTORY = 'graphics'

  searchable do
    text :caption, :default_boost => 0.5
  end

  def get_relative_image_path
    issue = Issue.find(self.issue_id)
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.image}"
  end

  def get_article_for_graphic
    article = Article.find(self.article_id)
    article
  end

  def render_search_view
    render partial: 'graphics/search_view',
      locals: {graphic: self, article: get_article_for_graphic}
  end
end
