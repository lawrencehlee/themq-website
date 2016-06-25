class ExtendVarcharLengthOfCaptions < ActiveRecord::Migration
  def change
		change_column :graphics, :caption, :text
  end
end
