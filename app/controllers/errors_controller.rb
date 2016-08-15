class ErrorsController < ApplicationController
  NAVBAR_ITEM = "Top Tens"

  def index
    status_code = params[:code] || 500

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
  end

end
