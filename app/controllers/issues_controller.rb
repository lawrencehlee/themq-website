class IssuesController < ApplicationController

  def show
    @issue = Issue.friendly.find(params[:id])
  end

  def index
    @issues = Issue.order_by_date(Issue.all, true)
    @articles = Article.all
    @issues = Issue.all
  end

  def all
    @issues = Issue.order_by_date(Issue.all, true)
    @issues = Issue.all
  end
end
