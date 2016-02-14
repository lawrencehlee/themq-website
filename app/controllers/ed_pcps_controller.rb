class EdPcpsController < ApplicationController

  def index
  end

  def show
    @ed_pcp = EdPcp.find(params[:id])
  end

end
