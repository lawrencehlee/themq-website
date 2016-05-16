class RemoveTextFromSelfAds < ActiveRecord::Migration
  def change
		remove_column :self_ads, :text
  end
end
