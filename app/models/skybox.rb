class Skybox < ActiveRecord::Base
  belongs_to :issue

  IMAGE_SUBDIRECTORY = 'skyboxes'

  def get_relative_image_path
    issue_string = "#{issue.volume_no}.#{issue.issue_no}"
    "#{issue_string}/#{IMAGE_SUBDIRECTORY}/#{self.image}"
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
