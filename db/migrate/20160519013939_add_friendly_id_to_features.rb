class AddFriendlyIdToFeatures < ActiveRecord::Migration
  def change
		add_column :features, :slug, :string
		add_index :features, :slug
		add_column :features, :name, :string
  end
end
