class Tag < ActiveRecord::Base

	def get_all_articles_with_tag
		article_tags = ArticleTag.where(tag_id: self.tag_id)
		articles = Array.new()
		article_tags.each do |article_tag|
			articles << Article.find(article_tag.article_id)
		end
		articles
	end

end
