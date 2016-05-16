class AddSlugToEdPcps < ActiveRecord::Migration
  def change
    add_column :ed_pcps, :slug, :string
		add_index :ed_pcps, :slug
  end
end
