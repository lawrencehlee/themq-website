class AddNameToEdPcps < ActiveRecord::Migration
  def change
		add_column :ed_pcps, :name, :string
  end
end
