require 'render_anywhere'
require_relative '../storage-adapters/graphic_storage_adapter'

class Graphic < ActiveRecord::Base
  include RenderAnywhere

  belongs_to :article
  belongs_to :person

  delegate :issue, to: :article

  searchable do
    text :caption, :default_boost => 0.5
  end

  def get_full_image_path
    path_structure = "/" + GraphicStorageAdapter::IMAGE_SUBDIRECTORY_STRUCTURE
    Settings.assets.uri_base + path_structure % [issue.get_abbreviated_issue_name_without_sub_issue, self.image]
  end

  def render_search_view
    render partial: 'graphics/search_view',
      locals: {graphic: self, article: get_article_for_graphic}
  end

  def self.order_by_issue_date(graphics, descending)
    if descending
      graphics.joins(:article => :issue).order('issues.date DESC')
    else
      graphics.joins(:article => :issue).order('issues.date')
    end
  end
end
