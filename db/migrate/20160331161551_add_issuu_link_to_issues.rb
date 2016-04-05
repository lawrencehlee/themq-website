class AddIssuuLinkToIssues < ActiveRecord::Migration
  def change
		add_column :issues, :issuu_link, :string
  end
end
