class Issue < ActiveRecord::Base

  IMAGE_SUBDIRECTORY = 'general'
  IMAGE_SUBDIRECTORY_STRUCTURE = "/images/%s/general/%s"

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

  def get_abbreviated_issue_name_without_sub_issue
      "#{self.volume_no}.#{self.issue_no}"
  end

  # Returns the issue date in the form January 5, 2025
  def get_human_readable_date
    self.date.to_formatted_s(:long)
  end

  def get_long_info
    "#{self.get_full_issue_name} - #{self.get_human_readable_date}"
  end

  def get_full_celeb_photo_path
    Settings.assets.uri_base + IMAGE_SUBDIRECTORY_STRUCTURE % [self.get_abbreviated_issue_name_without_sub_issue, self.celeb_photo]
  end

  def get_full_staff_photo_path
    Settings.assets.uri_base + IMAGE_SUBDIRECTORY_STRUCTURE % [self.get_abbreviated_issue_name_without_sub_issue, self.staff_photo]
  end

  # Returns the index.txt file in the latest issue, as an array of lines
  def self.get_index_txt_file
    issue = self.get_latest_issue
    issue_string = issue.get_abbreviated_issue_name
    filepath = File.join(
      Rails.root, 'app', 'assets', 'images', "#{issue_string}/#{IMAGE_SUBDIRECTORY}", 'index.txt')

    File.open(filepath).read.split("\n")
  end
end
