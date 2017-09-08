class RemoveGraphicIdFromArticles < ActiveRecord::Migration
  def change
    remove_foreign_key :articles, :graphics
    remove_column :articles, :graphic_id
    change_column_null :graphics, :article_id, false
  end
end
