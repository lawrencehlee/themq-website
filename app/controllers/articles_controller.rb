class ArticlesController < ApplicationController
  RELATED_CONTENT_LIMIT = 2
  SAME_AUTHOR_CONTENT_LIMIT = 1
  RELATED_CONTENT_TYPES = [Article, EdPcp]
  SAME_AUTHOR_CONTENT_TYPES = [Article]

  def show
    @article = Article.friendly.find(params[:id])
    @article_text = @article.get_article_text
    unless @article.brief == "1"
      @graphic = Graphic.find(@article.graphic_id)
      @graphic_designer = Person.find(@graphic.person_id)
    end
    @issue = Issue.find(@article.issue_id)
    @author = Person.find(@article.person_id)
    @author_position = @author.get_title
    @co_author = @article.get_co_author_or_nil
    @co_author_position = nil
    if @co_author
      @co_author_position = @co_author.get_title
    end


    @tags = Array.new()
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
  end

  def index
    @current_issue = Issue.get_latest_issue
    @top_story = Article.find(Article.first.get_top_story)
    @top_story_graphic = Graphic.find(@top_story.graphic_id)
    @top_story_issue = Issue.find(@top_story.issue_id)
    @top_story_person = Person.find(@top_story.person_id)
    @top_story_co_author = @top_story.get_co_author_or_nil

    @more_stories = Array.new()
    @more_stories_graphics = Array.new()
    Article.first.get_more_stories.each do |article_id|
      article = Article.find(article_id)
      @more_stories << article
      @more_stories_graphics << Graphic.find(article.graphic_id)
    end

    @random_top_ten = TopTen.get_random_from_issue(@current_issue)
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief_from_issue(@current_issue)
    @skybox = nil
  end

  def all
    @current_issue = Issue.get_latest_issue
    @articles = Article.order('article_id DESC').page(params[:page]).per(10)
    @random_top_ten = TopTen.get_random
    @random_self_ad = SelfAd.get_random
    @brief = Article.get_random_brief
    @skybox = nil
  end
end
