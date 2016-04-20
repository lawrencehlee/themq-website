class EdPcpsController < ApplicationController

  def index
  end

  def show
    @ed_pcp = EdPcp.find(params[:id])
		@issue = Issue.find(@ed_pcp.issue_id)

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

	def all
		#here I want to paginate through an array of pieces.
		#each element of the array will be a list of editorials
		#those lists of length 1 will just be a single editorial
		#those lists of length 2 will be ordered [point, counterpoint], and will be bundled together

		@ed_pcps = EdPcp.order('ed_pcp_id DESC')
		@grouped_ed_pcps = Array.new
		@ed_pcps.each do |ed_pcp|
			if ed_pcp.ed == "1"
				@grouped_ed_pcps << Array.new(1, ed_pcp)
			end
		  if ed_pcp.point == "1"
				@grouped_ed_pcps << EdPcp.group_point_counterpoint(ed_pcp)
			end
		end

		@grouped_ed_pcps = Kaminari.paginate_array(@grouped_ed_pcps).page(params[:page]).per(10)
	end

end
