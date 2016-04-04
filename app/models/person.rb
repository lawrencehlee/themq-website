class Person < ActiveRecord::Base

	def get_all_articles_for_person
		articles = Article.where(person_id: self.person_id)
		articles
	end
end
