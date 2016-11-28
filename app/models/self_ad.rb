class SelfAd < ActiveRecord::Base
  belongs_to :issue

  IMAGE_SUBDIRECTORY = 'self_ads'

  def get_relative_image_path
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.image}"
  end

  def self.get_all_from_issue(issue)
    SelfAd.where(issue_id: issue.issue_id)
  end

  # Static method that gets a random self ad from the specified issue
  def self.get_random_from_issue(issue)
    SelfAd.get_all_from_issue(issue).sample
  end

  def self.get_random
    SelfAd.all.sample
  end
end
