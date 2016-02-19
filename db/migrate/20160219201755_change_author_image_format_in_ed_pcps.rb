class ChangeAuthorImageFormatInEdPcps < ActiveRecord::Migration
  def change
      change_column :ed_pcps, :author_image, :string
  end
end
