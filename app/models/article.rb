require 'render_anywhere'

class Article < ActiveRecord::Base
  include RenderAnywhere, RandomSelectable

  belongs_to :issue
  has_one :graphic
  has_many :article_tags
  has_many :tags, through: :article_tags
  belongs_to :author, class_name: "Person"
  belongs_to :co_author, class_name: "Person"

  accepts_nested_attributes_for :graphic, update_only: true, allow_destroy: true

  searchable do
    text :headline, :default_boost => 1.5
  end

  def get_text_location
    path_structure = "/" + ArticleStorageAdapter::ARTICLE_SUBDIRECTORY_STRUCTURE
    Settings.assets.uri_base + path_structure % [issue.get_abbreviated_issue_name_without_sub_issue, self.text]
  end

  def get_attribution_line
    "#{person.name} - #{issue.get_long_info}"
  end

  # Used to cache the text so that a request isn't made for this object every single time
  def get_full_text
    if @full_text.nil?
      @full_text = ApplicationController.helpers.get(self.get_text_location)
    end
    @full_text
  end

  def get_text_teaser(words)
    text = self.get_full_text
    first_paragraph_words = text.split("\n\n")[0].split()
    first_paragraph_words[0..words].join(' ') + "..."
  end

  def self.get_top_story
    Article.find(Settings.articles.top_story)
  end

  def self.get_more_stories
    Settings.articles.more_stories.collect { |id| Article.find(id) }
  end

  def get_tags
    tags = Array.new()
    ArticleTag.where(article_id: self.article_id).each do |article_tag|
      tags << Tag.find(article_tag.tag_id)
    end
    tags
  end

  def self.get_all_briefs_from_issue(issue)
    Article.get_all_briefs.where(issue_id: issue.issue_id)
  end

  def self.get_random_brief_from_issue(issue)
    Article.random(Article.get_all_briefs_from_issue(issue))
  end

  def self.get_all_briefs
    Article.where(brief: 1)
  end

  def self.get_random_brief
    Article.random(Article.get_all_briefs)
  end

  def render_sidebar_view
    render partial: 'articles/sidebar_view', locals: {:article => self}
  end

  #want to do the same thing as render_sidebar_view, but for the tag page
  def render_tag_view
    if brief
      render partial: 'articles/tag_view', locals: {:article => self, :graphic => nil}
    else
      render partial: 'articles/tag_view', locals: {:article => self, :graphic => graphic}
    end
  end

  def render_tag_show_view
    if brief
      render partial: 'articles/tag_show_view', locals: {:article => self, :graphic => nil}
    else
      render partial: 'articles/tag_show_view', locals: {:article => self, :graphic => graphic}
    end
  end

  def render_search_view
    render partial: 'articles/search_view', locals: {article: self}
  end

  # Returns an array of content models that are "related" by tag to
  # this article. It will find up to limit results that are of the
  # classes specified in the content_types parameter.
  # The filter parameter is used for any other miscellaneous
  # criteria in querying for models.
  def get_related_content(limit, content_types, filter)
    related_content = Array.new
    tags = get_tags
    rest_of_content_types = content_types

    # Do Article first to exclude self
    if content_types.include?(Article)
      rest_of_content_types = content_types - [Article]
      prevent_duplicate_filter = "article_id != #{self.article_id}"
      new_filter = [filter, prevent_duplicate_filter].join(" AND ")
      related_content += Article.find_with_tags(tags, new_filter)
    end
    rest_of_content_types.each do |content_type|
        related_content += content_type.find_with_tags(tags, filter)
    end

    # Get limit random items from the content
    related_content.uniq.sample(limit)
  end

  # Returns an array of articles that are filtered by filter
  # and that have any of the tags specified in tags
  def self.find_with_tags(tags, filter)
    # Getting all the ids and querying like so is much faster than individually
    # querying for each id
    article_tags = tags.collect { |tag| ArticleTag.where({tag_id: tag.tag_id}) }.flatten
    article_ids = article_tags.collect { |article_tag| article_tag.article_id }
    Article.where(article_id: article_ids.uniq).where(filter)
  end

  def get_co_author_or_nil
    if self.co_author
      return Person.find(self.co_author)
    end
    nil
  end

  # returns the article title w/o the slash. Eg. 22.5/Greenb -> Greenb
  def strip_article_title
    self.title.partition("/")[2..-1].join('')
  end

  def self.order_by_issue_date(articles, descending)
    if descending
      articles.joins(:issue).order('issues.date DESC')
    else
      articles.joins(:issue).order('issues.date')
    end
  end
end
