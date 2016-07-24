class AddFriendlyIdToIssues < ActiveRecord::Migration
  def change
		add_column :issues, :slug, :string
		add_index :issues, :slug
		add_column :issues, :name, :string
  end
end
