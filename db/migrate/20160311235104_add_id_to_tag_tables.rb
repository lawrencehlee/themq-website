class AddIdToTagTables < ActiveRecord::Migration
  def change
		add_column :article_tags, :article_tag_id, :primary_key, first: true
		add_column :ed_pcp_tags, :ed_pcp_tag_id, :primary_key, first: true
		add_column :feature_tags, :feature_tag_id, :primary_key, first: true
		add_column :top_ten_tags, :top_ten_tag_id, :primary_key, first: true
  end
end
