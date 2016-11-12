class StaticPagesController < ApplicationController
  def about
    @current_issue = Issue.get_latest_issue

    @random_top_ten = nil
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil
  end

  def contact
    @current_issue = Issue.get_latest_issue

    @random_top_ten = nil
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil
  end

end
