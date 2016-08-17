class FeaturesController < ApplicationController
  before_filter :setup_sidebar_variables

  RELATED_CONTENT_LIMIT = 2
  SAME_AUTHOR_CONTENT_LIMIT = 1
  RELATED_CONTENT_TYPES = [Article, EdPcp]
  NAVBAR_ITEM = "Features"

  def index
    @top_feature = Feature.find(Feature.get_top_feature)
    @columnFeatures = Array.new()
    Feature.get_column_features.each do |feat_id|
      @columnFeatures << Feature.find(feat_id)
    end
    @moreFeatures = Feature.get_more_features
    @moreFeatures = Array.new()
    Feature.get_more_features.each do |feat_id|
      @moreFeatures << Feature.find(feat_id)
    end

    @all_features = [@top_feature] + @columnFeatures + @moreFeatures

    @navbar_item = NAVBAR_ITEM
  end

  def all
    #here we want to show all the features clumped by issue.
    #That means having an array of length num_of_issues,
    #with each element in that array being an array of the features in the issue
    @allFeatures = Array.new()
    Issue.order("volume_no, issue_no").each do |issue|
      feature_set = Feature.where(issue_id: issue.issue_id)
      if feature_set != nil
        @allFeatures << Feature.where(issue_id: issue.issue_id)
      end
    end
    @feature_sets = @allFeatures[1..-1].reverse
    @navbar_item = NAVBAR_ITEM

    @random_top_ten = TopTen.get_random
    @brief = Article.get_random_brief
  end

  def show
    @feature = Feature.friendly.find(params[:id])
    @feature_path = "/assets/" + @feature.get_relative_feature_path
    @width = @feature.width
    @height = @feature.height
    @tags = Array.new()
    @tags = @feature.get_tags
    @navbar_item = NAVBAR_ITEM

    # Specific sidebar stuff
    current_issue_filter = "issue_id = #{@issue.issue_id}"
    not_current_issue_filter = "issue_id != #{@issue.issue_id}"

    @related_content = @feature.get_related_content(
      RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, current_issue_filter)
    @related_content += @feature.get_related_content(
      RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, not_current_issue_filter)
  end

  protected
  def setup_sidebar_variables
    @current_issue = Issue.get_latest_issue
    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief_from_issue(@current_issue)
  end
end
