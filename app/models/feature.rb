require 'render_anywhere'

class Feature < ActiveRecord::Base
  extend FriendlyId
  include RenderAnywhere

  belongs_to :issue
  friendly_id :name, use: :slugged
  FEATURE_SUBDIRECTORY = 'features'

  searchable do
    text :title
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end

  def get_issue
    Issue.find(self.issue_id)
  end

  def get_relative_feature_path
    issue = Issue.find(self.issue_id)
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{FEATURE_SUBDIRECTORY}/#{self.image}"
  end

  def get_tags
    tags = Array.new()
    FeatureTag.where(feature_id: self.feature_id).each do |feature_tag|
      tags << Tag.find(feature_tag.tag_id)
    end
    tags
  end


  def self.get_top_feature
    issue = Issue.last
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

    f_lines = File.open(filepath).read.split("\n")
    f_lines.each_with_index do |line, index|
      if line.include? "top feature"
        return f_lines[index + 1]
      end
    end
  end

  def self.get_column_features
    issue = Issue.last
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

    f_lines = File.open(filepath).read.split("\n")
    f_lines.each_with_index do |line, index|
      if line.include? "column features"
        return f_lines[index + 1].split(",")
      end
    end
  end

  def self.get_more_features
    issue = Issue.last
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'images', "#{issue_string}", 'features', 'topFeatures.txt')

    f_lines = File.open(filepath).read.split("\n")
    f_lines.each_with_index do |line, index|
      if line.include? "more features"
        return f_lines[index + 1].split(",")
      end
    end
  end

  def render_tag_view
    render partial: 'features/tag_view', locals: {:feature => self}
  end

  def render_tag_show_view
    render partial: 'features/tag_show_view', locals: {:feature => self}
  end

  def render_search_view
    render partial: 'features/search_view', locals: {feature: self}
  end

  def get_related_content(limit, content_types, filter)
    related_content = Array.new
    tags = get_tags
    rest_of_content_types = content_types

    if content_types.include?(Feature)
      rest_of_content_types = content_types - [Feature]
      prevent_duplicate_filter = "feature_id != #{self.feature_id}"
      new_filter = [filter, prevent_duplicate_filter].join(" AND ")
      related_content += Feature.find_with_tags(tags, new_filter)
    end
    rest_of_content_types.each do |content_type|
        related_content += content_type.find_with_tags(tags, filter)
    end

    # Get limit random items from the content
    related_content.uniq.sample(limit)
  end

  def self.find_with_tags(tags, filter)
    # Getting all the ids and querying like so is much faster than individually
    # querying for each id
    feature_tags = tags.collect { |tag| FeatureTag.where({tag_id: tag.tag_id}) }.flatten
    feature_ids = feature_tags.collect { |feature_tag| feature_tag.feature_id }
    Feature.(feature_id: feature_ids.uniq).where(filter)
  end
end
