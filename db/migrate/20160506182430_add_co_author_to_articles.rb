class AddCoAuthorToArticles < ActiveRecord::Migration
  def change
		add_column :articles, :co_author, :integer
  end
end
