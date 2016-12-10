class FeatureTag < ActiveRecord::Base
  belongs_to :feature
  belongs_to :tag
end
