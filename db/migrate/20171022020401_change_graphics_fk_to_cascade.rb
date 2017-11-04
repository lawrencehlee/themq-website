class ChangeGraphicsFkToCascade < ActiveRecord::Migration
  def change
    remove_foreign_key :graphics, :articles
    Graphic.connection.execute("ALTER TABLE graphics ADD CONSTRAINT `fk_graphics_articles` FOREIGN KEY (`article_id`) REFERENCES articles (`article_id`) ON DELETE CASCADE;")
  end
end
