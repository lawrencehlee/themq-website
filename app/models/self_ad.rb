class SelfAd < ActiveRecord::Base
  belongs_to :issue

  IMAGE_SUBDIRECTORY_STRUCTURE = "/images/%s/self_ads/%s"

  def get_full_image_path
    Settings.assets.uri_base + IMAGE_SUBDIRECTORY_STRUCTURE % [issue.get_abbreviated_issue_name_without_sub_issue, self.image]
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
