class RemoveFriendlyId < ActiveRecord::Migration
  def change
    remove_column :articles, :slug
    remove_column :ed_pcps, :slug
    remove_column :features, :slug
    remove_column :top_tens, :slug
    remove_column :issues, :slug
  end
end
