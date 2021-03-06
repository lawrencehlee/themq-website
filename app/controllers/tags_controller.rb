class TagsController < ApplicationController
  def index
    @tag_id = params[:tag_id]
    if @tag_id == nil
      @tag_id = Tag.offset(rand(Tag.count)).first
    end
    @tag = Tag.find(@tag_id)


    @articles, @briefs = @tag.get_all_articles_with_tag
    @ed_pcps = @tag.get_all_ed_pcps_with_tag
    @features = @tag.get_all_features_with_tag
    @top_tens = @tag.get_all_top_tens_with_tag
    @features = @tag.get_all_features_with_tag

    @random_top_ten = nil
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil
  end

  def show
    @tag_id = params[:tag_id]
    @tag = Tag.find(@tag_id)
    @content_type = params[:content_type]

    case @content_type
    when "article"
      articles, briefs = @tag.get_all_articles_with_tag
      @content_pieces = (articles + briefs).shuffle(random: Random.new(1))
      @type_name = "Articles"
    when "ed_pcp"
      @content_pieces = @tag.get_all_ed_pcps_with_tag
      @type_name = "Editorials"
    when "top_ten"
      @content_pieces = @tag.get_all_top_tens_with_tag
      @type_name = "Top Tens"
    when "feature"
      @content_pieces = @tag.get_all_features_with_tag
      @type_name = "Features"
    end

    @content_pieces = Kaminari.paginate_array(@content_pieces).page(params[:page]).per(10)

    @random_top_ten = TopTen.get_random
    @random_self_ad = SelfAd.get_random
    @brief = nil
    @skybox = nil
  end
end
