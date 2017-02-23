class Issue < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  IMAGE_SUBDIRECTORY = 'general'

  def should_generate_new_friendly_id?
    slug.blank? || self.name_changed?
  end

  # Static method that gets the latest issue by date
  def self.get_latest_issue
    Issue.where(current: true).first
  end

  # Returns the full issue name in the form Volume x Issue y
  def get_full_issue_name
    if is_sub_issue?
      "Volume #{self.volume_no} Issue #{self.issue_no}.#{self.sub_issue_no}"
    else
      "Volume #{self.volume_no} Issue #{self.issue_no}"
    end
  end

  def is_sub_issue?
    !self.sub_issue_no.nil?
  end

  # Returns the abbreviated issue name in the form x.y
  def get_abbreviated_issue_name
    if is_sub_issue?
      "#{self.volume_no}.#{self.issue_no}.#{self.sub_issue_no}"
    else
      "#{self.volume_no}.#{self.issue_no}"
    end
  end

  # Returns the issue date in the form January 5, 2025
  def get_human_readable_date
    self.date.to_formatted_s(:long)
  end

  def get_long_info
    "#{self.get_full_issue_name} - #{self.get_human_readable_date}"
  end

  def get_relative_celeb_photo_path
    "#{self.get_abbreviated_issue_name}/#{IMAGE_SUBDIRECTORY}/#{self.celeb_photo}"
  end

  # Returns the index.txt file in the latest issue, as an array of lines
  def self.get_index_txt_file
    issue = self.get_latest_issue
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'images', "#{issue_string}/#{IMAGE_SUBDIRECTORY}", 'index.txt')

    File.open(filepath).read.split("\n")
  end

  def self.get_top_articles(issue)
    Settings.issues[(issue.volume_no)][(issue.issue_no)].top_articles.collect { |id| Article.find(id) }
  end

  def self.get_top_ed_pcps(issue)
    Settings.issues[(issue.volume_no)][(issue.issue_no)].top_ed_pcps.collect { |id| EdPcp.find(id) }
  end

  def self.get_top_features(issue)
    Settings.issues[(issue.volume_no)][(issue.issue_no)].top_features.collect { |id| Feature.find(id) }
  end

  def self.get_top_top_tens(issue)
    Settings.issues[(issue.volume_no)][(issue.issue_no)].top_top_tens.collect { |id| TopTen.find(id) }
  end
end
