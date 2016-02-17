class EdPcpsController < ApplicationController

  def index
  end

  def show
    @ed_pcp = EdPcp.find(params[:id])
   
    @ed_pcps = Array.new
    @ed_pcps << @ed_pcp


    if @ed_pcp.point == "1"
        @cp = EdPcp.find(@ed_pcp.crspnd_point_id)
        @ed_pcps << @cp
    end
  end

end
