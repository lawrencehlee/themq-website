class TopTenTag < ActiveRecord::Base
  belongs_to :top_ten
  belongs_to :tag
end
