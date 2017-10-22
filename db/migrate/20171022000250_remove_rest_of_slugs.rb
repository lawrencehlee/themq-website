class RemoveRestOfSlugs < ActiveRecord::Migration
  def change
    remove_column :people, :slug
    remove_column :tags, :slug
    drop_table :personal_tests
  end
end
