class AddSizesToFeatures < ActiveRecord::Migration
  def change
		add_column :features, :height, :int
		add_column :features, :width, :int
  end
end
