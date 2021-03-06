class Tag < ActiveRecord::Base

  def get_all_articles_with_tag
    article_tags = ArticleTag.where(tag_id: self.tag_id)
    articles = Array.new()
    briefs = Array.new()
    all_articles = article_tags.map { |article_tag| Article.find(article_tag.article_id) }
    articles = all_articles.select { |article| not article.brief }
    briefs = all_articles.select { |article| article.brief }
    [articles, briefs]
  end

  def get_all_ed_pcps_with_tag
    ed_pcp_tags = EdPcpTag.where(tag_id: self.tag_id)
    ed_pcps = Array.new()
    ed_pcp_tags.each do |ed_pcp_tag|
      ed_pcp =  EdPcp.find(ed_pcp_tag.ed_pcp_id)
      if ed_pcp.counterpoint == "0"
        ed_pcps << ed_pcp
      end
    end
    ed_pcps
  end

  def get_all_features_with_tag
    feature_tags = FeatureTag.where(tag_id: self.tag_id)
    features = Array.new()
    feature_tags.each do |feature_tag|
      features << Feature.find(feature_tag.feature_id)
    end
    features
  end

  def get_all_top_tens_with_tag
    top_ten_tags = TopTenTag.where(tag_id: self.tag_id)
    top_tens = Array.new()
    top_ten_tags.each do |top_ten_tag|
      top_tens << TopTen.find(top_ten_tag.top_ten_id)
    end
    top_tens
  end

  def get_all_features_with_tag
    feature_tags = FeatureTag.where(tag_id: self.tag_id)
    features = Array.new()
    feature_tags.each do |feature_tag|
      features << Feature.find(feature_tag.feature_id)
    end
    features
  end

end
