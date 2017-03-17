class ArticlesController < ApplicationController
  RELATED_CONTENT_LIMIT = 2
  SAME_AUTHOR_CONTENT_LIMIT = 1
  RELATED_CONTENT_TYPES = [Article, EdPcp]
  SAME_AUTHOR_CONTENT_TYPES = [Article]

  def show
    @article = Article.friendly.find(params[:id])
    @article_text = @article.get_article_text
    unless @article.brief
      @graphic = @article.graphic
      @graphic_designer = @graphic.person
    end
    @issue = @article.issue
    @author = @article.author
    @author_position = @author.get_title
    @co_author = @article.co_author
    @co_author_position = nil
    if @co_author
      @co_author_position = @co_author.get_title
    end

    @tags = @article.get_tags

    # Specific sidebar stuff
    current_issue_filter = "issue_id = #{@issue.issue_id}"
    not_current_issue_filter = "issue_id != #{@issue.issue_id}"

    @related_content = @article.get_related_content(
        RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, current_issue_filter)
    @related_content += @article.get_related_content(
        RELATED_CONTENT_LIMIT, RELATED_CONTENT_TYPES, not_current_issue_filter)

    @same_author_content = @author.get_more_content(
        SAME_AUTHOR_CONTENT_LIMIT, SAME_AUTHOR_CONTENT_TYPES,
        current_issue_filter, @article)
    @same_author_content += @author.get_more_content(
        SAME_AUTHOR_CONTENT_LIMIT, SAME_AUTHOR_CONTENT_TYPES,
        not_current_issue_filter, @article)

    @same_co_author_content = Array.new
    if @co_author
      @same_co_author_content = @co_author.get_more_content(
          SAME_AUTHOR_CONTENT_LIMIT, SAME_AUTHOR_CONTENT_TYPES,
          current_issue_filter, @article)
      @same_co_author_content += @co_author.get_more_content(
          SAME_AUTHOR_CONTENT_LIMIT, SAME_AUTHOR_CONTENT_TYPES,
          not_current_issue_filter, @article)
    end
  end

  def index
    @current_issue = Issue.get_latest_issue
    @top_story = Article.get_top_story
    @top_story_graphic = @top_story.graphic
    @top_story_issue = @top_story.issue
    @top_story_person = @top_story.author
    @top_story_co_author = @top_story.co_author
    @more_stories = Article.get_more_stories
    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief_from_issue(@current_issue)
    @skybox = nil
  end

  def all
    @current_issue = Issue.get_latest_issue
    @articles = Article.order_by_issue_date(Article.all, true).page(params[:page]).per(10)
    @random_top_ten = TopTen.get_random
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief
    @skybox = nil
  end
end
