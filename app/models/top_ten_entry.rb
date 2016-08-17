require 'render_anywhere'

class TopTenEntry < ActiveRecord::Base
  include RenderAnywhere

  searchable do
    text :text, :default_boost => 0.5
  end

  # Gets the full text of the top ten like so: 10. This is an entry
  def get_full_text
    "#{self.entry_no}. #{self.text}"
  end

  def get_top_ten
    TopTen.find(self.top_ten_id)
  end

  def render_search_view
    render partial: 'top_ten_entries/search_view',
      locals: {top_ten_entry: self, top_ten: get_top_ten}
  end
end
