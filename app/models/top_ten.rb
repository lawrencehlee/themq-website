require 'render_anywhere'

class TopTen < ActiveRecord::Base
  include RenderAnywhere, RandomSelectable

  belongs_to :issue
  has_many :top_ten_entries

  accepts_nested_attributes_for :top_ten_entries

  searchable do
    text :title
  end

  # Static method that gets all top tens from the specified issue
  def self.get_all_from_issue(issue)
    TopTen.where(issue_id: issue.issue_id)
  end

  # Static method that gets a random top ten from the specified issue
  def self.get_random_from_issue(issue)
    all_from_issue = TopTen.get_all_from_issue(issue)
    TopTen.random(all_from_issue)
  end

  # Static method that gets a random top ten from anywhere in the database
  # so long as it's not the top ten passed in.
  def self.get_random_from_db(current_top_ten_id)
    all_from_db = TopTen.where.not(top_ten_id: current_top_ten_id)
    TopTen.random(all_from_db)
  end

  def self.get_random
    TopTen.random(TopTen.all)
  end

  # Gets the entries associated with this top ten
  def get_entries
    TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
  end

  def render_tag_view
    render partial: 'top_tens/tag_view', locals: {:top_ten => self}
  end

  def render_tag_show_view
    render partial: 'top_tens/tag_show_view', locals: {:top_ten => self}
  end

  def render_search_view
    render partial: 'top_tens/search_view', locals: {top_ten: self}
  end

  # Gets top ten entries 10 through 7.
  def get_top_ten_entries_teaser
    number_of_entries = 4
    TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc").first(number_of_entries)
    #TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
  end

  def get_attribution_line
    "#{issue.get_full_issue_name} - #{issue.get_human_readable_date}"
  end

  def get_top_ten_tags
    TopTenTag.where(top_ten_id: self.top_ten_id).collect { |top_ten_tag| top_ten_tag.tag }
  end

  def self.order_by_issue_date(top_tens, descending)
    if descending
      top_tens.joins(:issue).order('issues.date DESC')
    else
      top_tens.joins(:issue).order('issues.date')
    end
  end
end
