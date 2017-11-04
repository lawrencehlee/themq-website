class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :set_var

  HEADER_TEXT = "white"

  private
  def set_var
    @logo_image = "logo_#{HEADER_TEXT}_transparent.png"
  end
end
