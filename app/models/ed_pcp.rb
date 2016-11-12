require 'render_anywhere'

class EdPcp < ActiveRecord::Base
  extend FriendlyId
  include RenderAnywhere

  belongs_to :issue
  friendly_id :title, use: :slugged
  IMAGE_SUBDIRECTORY = 'ed_pcps'
  ARTICLE_SUBDIRECTORY = 'articles'

  searchable do
    text :headline, :author, :author_title
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

  def get_issue
    Issue.find(self.issue_id)
  end

  def get_ed_pcp_text
    filepath = File.join(
      Rails.root, 'app', 'assets', 'articles', self.get_relative_article_path)
    File.read(filepath).encode("UTF-8", :invalid=>:replace)
  end

  def get_relative_article_path
    issue = Issue.find(self.issue_id)
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{ARTICLE_SUBDIRECTORY}/#{self.text}"
  end

  def get_relative_author_image_path
    issue = Issue.find(self.issue_id)
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.author_image}"
  end

  def self.group_point_counterpoint(point)
    [point, point.get_counterpoint]
  end

  def get_ed_pcp_tags
    tags = Array.new
    EdPcpTag.where(ed_pcp_id: self.ed_pcp_id).each do |ed_pcp_tag|
      tags << Tag.find(ed_pcp_tag.tag_id)
    end
    tags
  end

  def self.get_top_editorials
    issue = Issue.get_latest_issue
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topEd_pcps.txt')

    f_lines = File.open(filepath).read.split("\n")
    f_lines.each_with_index do |line, index|
      if line.include? "editorials"
        return f_lines[index + 1].split(",")
      end
    end
  end

  def self.get_top_pcps
    issue = Issue.get_latest_issue
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'articles', "#{issue_string}", 'topEd_pcps.txt')

    f_lines = File.open(filepath).read.split("\n")
    f_lines.each_with_index do |line, index|
      if line.include? "point_counterpoints"
        return f_lines[index + 1].split(",")
      end
    end
  end


  def get_ed_pcp_text_teaser
    filepath = File.join(
      Rails.root, 'app', 'assets', 'articles', self.get_relative_article_path)
    n = 1;
    open(filepath) do |f|
      lines = []
      n.times do
        line = f.gets || break
        lines << line
      end
      first_line = lines.first
      first_line.split(' ')[0, 25].join(' ') + "...";

    end
  end

  def render_tag_view
    ed_pcp = self
    if self.counterpoint == 1
      ed_pcp = EdPcp.find(self.crspnd_point)
    end
    render partial: 'ed_pcps/tag_view', locals: {ed_pcp: ed_pcp}
  end

  def render_tag_show_view
    ed_pcp = self
    if self.counterpoint == 1
      ed_pcp = EdPcp.find(self.crspnd_point)
    end
    render partial: 'ed_pcps/tag_show_view', locals: {ed_pcp: ed_pcp}
  end

  def render_search_view
    render partial: 'ed_pcps/search_view', locals: {ed_pcp: self}
  end

  def get_tags
    tags = Array.new()
    EdPcpTag.where(ed_pcp_id: self.ed_pcp_id).each do |ed_pcp_tag|
      tags << Tag.find(ed_pcp_tag.tag_id)
    end
    tags
  end

  def get_related_content(limit, content_types, filter)
    related_content = Array.new
    tags = get_tags
    rest_of_content_types = content_types

    if content_types.include?(EdPcp)
      rest_of_content_types = content_types - [EdPcp]
      prevent_duplicate_filter = "ed_pcp_id != #{self.ed_pcp_id}"
      new_filter = [filter, prevent_duplicate_filter].join(" AND ")
      related_content += EdPcp.find_with_tags(tags, new_filter)
    end
    rest_of_content_types.each do |content_type|
      related_content += content_type.find_with_tags(tags, filter)
    end

    # Get limit random distinct items from the content
    related_content.uniq.sample(limit)
  end

  # self.find_with_tags(tags, filter)
  # Returns an array of ed/pcps that are filtered by filter
  # and that have all the tags specified in tags
  def self.find_with_tags(tags, filter)
    # Getting all the ids and querying like so is much faster than individually
    # querying for each id
    ed_pcp_tags = tags.collect { |tag| EdPcpTag.where({tag_id: tag.tag_id}) }.flatten
    ed_pcp_ids = ed_pcp_tags.collect { |ed_pcp_tag| ed_pcp_tag.ed_pcp_id }
    EdPcp.where(ed_pcp_id: ed_pcp_ids.uniq).where(filter)
  end

  def is_ed?
    return self.ed == "1"
  end

  def is_point?
    return self.point == "1"
  end

  def get_counterpoint
    EdPcp.where(crspnd_point_id: self.ed_pcp_id).first
  end

  def render_sidebar_view
    render partial: 'ed_pcps/sidebar_view', locals: {ed_pcp: self}
  end

  def self.order_by_issue_date(ed_pcps, descending)
    if descending
      ed_pcps.joins(:issue).order('issues.date DESC')
    else
      ed_pcps.joins(:issue).order('issues.date')
    end
  end
end
