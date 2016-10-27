class ErrorsController < ApplicationController
  NAVBAR_ITEM = "Top Tens"

  def not_found
    @top_ten = TopTen.offset(rand(TopTen.count)).first
    i = 1
    @entries = Array.new()
    while i < (@top_ten.no_of_entries + 1) do
      @entries << TopTenEntry.where(entry_no: i).sample
      i = i + 1
    end
    @entries = @entries.reverse
    @navbar_item = NAVBAR_ITEM
    @random_top_ten = nil
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil

    render :status => 404
  end

  def internal_server_error
    @top_ten = TopTen.offset(rand(TopTen.count)).first
    i = 1
    @entries = Array.new()
    while i < (@top_ten.no_of_entries + 1) do
      @entries << TopTenEntry.where(entry_no: i).sample
      i = i + 1
    end
    @entries = @entries.reverse
    @navbar_item = NAVBAR_ITEM
    @random_top_ten = nil
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil

    render :status => 500
  end

end
