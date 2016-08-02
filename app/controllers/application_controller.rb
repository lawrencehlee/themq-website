class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_var

  HEADER_TEXT = "white"

  private
  def set_var
		@issue = Issue.get_latest_issue
		if rand >= 0.5
			@celeb_quote = @issue.celeb_quote
			@celeb = @issue.celeb
		else
			@masthead = @issue.masthead
		end
    @logo_image = "logo_#{HEADER_TEXT}_transparent.png"
  end
end
