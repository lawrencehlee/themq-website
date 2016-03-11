class EdPcpsController < ApplicationController

  def index
  end

  def show
    @ed_pcp = EdPcp.find(params[:id])
   
    @ed_pcps = Array.new
    @ed_pcps << @ed_pcp
    @tags = Array.new
    EdPcpTag.where(ed_pcp_id: params[:id]).each do |ed_pcp_tag|
        @tags << Tag.find(ed_pcp_tag.tag_id)
    end


    if @ed_pcp.point == "1"
        @cp = EdPcp.find(@ed_pcp.crspnd_point_id)
        @ed_pcps << @cp
    end
  end

end
