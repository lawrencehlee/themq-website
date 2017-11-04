class ChangeAllRelevantFksToCascadeDelete < ActiveRecord::Migration
  def change
    ArticleTag.connection.execute("ALTER TABLE article_tags ADD CONSTRAINT `fk_article_tags_article` FOREIGN KEY (`article_id`) REFERENCES articles (`article_id`) ON DELETE CASCADE;")

    remove_foreign_key :feature_tags, :feature
    FeatureTag.connection.execute("ALTER TABLE feature_tags ADD CONSTRAINT `fk_feature_tags_feature` FOREIGN KEY (`feature_id`) REFERENCES features (`feature_id`) ON DELETE CASCADE;")

    remove_foreign_key :ed_pcp_tags, :ed_pcp
    EdPcpTag.connection.execute("ALTER TABLE ed_pcp_tags ADD CONSTRAINT `fk_ed_pcp_tags_ed_pcp` FOREIGN KEY (`ed_pcp_id`) REFERENCES ed_pcps (`ed_pcp_id`) ON DELETE CASCADE;")

    remove_foreign_key :top_ten_tags, :top_ten
    TopTenTag.connection.execute("ALTER TABLE top_ten_tags ADD CONSTRAINT `fk_top_ten_tags_top_ten` FOREIGN KEY (`top_ten_id`) REFERENCES top_tens (`top_ten_id`) ON DELETE CASCADE;")
  end
end
