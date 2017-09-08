class Skybox < ActiveRecord::Base
  belongs_to :issue

  IMAGE_SUBDIRECTORY_STRUCTURE = "/images/%s/skyboxes/%s"

  def get_full_image_path
    Settings.assets.uri_base + IMAGE_SUBDIRECTORY_STRUCTURE % [issue.get_abbreviated_issue_name_without_sub_issue, self.image]
  end

  def self.get_all_from_issue(issue)
    Skybox.where(issue_id: issue.issue_id)
  end

  def self.get_random_from_issue(issue)
    Skybox.get_all_from_issue(issue).sample
  end

  def self.get_random
    Skybox.all.sample
  end
end
