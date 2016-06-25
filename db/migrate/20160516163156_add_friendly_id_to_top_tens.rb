class AddFriendlyIdToTopTens < ActiveRecord::Migration
  def change
		add_column :top_tens, :slug, :string
		add_index :top_tens, :slug
		add_column :top_tens, :name, :string
  end
end
