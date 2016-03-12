class ChangeLongblobsInTables < ActiveRecord::Migration
  def change
		change_column :features, :image, :string
		change_column :self_ads, :image, :string
		change_column :skyboxes, :image, :string
		change_column :articles, :text, :string
		change_column :ed_pcps, :text, :string
  end
end
