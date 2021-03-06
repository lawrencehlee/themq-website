class EdPcpsController < ApplicationController
  RELATED_CONTENT_LIMIT = 2
  RELATED_CONTENT_TYPES = [Article, EdPcp]
  SAME_AUTHOR_CONTENT_TYPES = [Article, EdPcp]

  def index
    @eds = EdPcp.get_top_editorials
    @pcps = EdPcp.get_top_pcps

    @current_issue = Issue.get_latest_issue
    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief_from_issue(@current_issue)
    @skybox = nil
  end

  def show
    @ed_pcp = EdPcp.find(params[:id])
    @issue = Issue.find(@ed_pcp.issue_id)

    @ed_pcps = Array.new
    @ed_pcps << @ed_pcp
    @tags = @ed_pcp.get_tags

    if @ed_pcp.point
      @cp = @ed_pcp.get_counterpoint
      @ed_pcps << @cp
    end

    # Specific sidebar stuff
    current_issue_filter = "issue_id = #{@issue.issue_id}"
    not_current_issue_filter = "issue_id != #{@issue.issue_id}"

    @related_content = @ed_pcp.get_related_content(
      RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, current_issue_filter)
    @related_content += @ed_pcp.get_related_content(
      RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, not_current_issue_filter)
  end

  def all
    #here I want to paginate through an array of pieces.
    #each element of the array will be a list of editorials
    #those lists of length 1 will just be a single editorial
    #those lists of length 2 will be ordered [point, counterpoint], and will be bundled together

    @ed_pcps = EdPcp.order_by_issue_date(EdPcp.all, true)
    @grouped_ed_pcps = Array.new
    @ed_pcps.each do |ed_pcp|
      if ed_pcp.ed
        @grouped_ed_pcps << [ed_pcp]
      end
      if ed_pcp.point
        @grouped_ed_pcps << EdPcp.group_point_counterpoint(ed_pcp)
      end
    end

    @grouped_ed_pcps = Kaminari.paginate_array(@grouped_ed_pcps).page(params[:page]).per(10)

    @current_issue = Issue.get_latest_issue
    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief
    @skybox = nil
  end
end
