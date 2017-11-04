class RemoveIssueIdFromGraphics < ActiveRecord::Migration
  def change
    remove_foreign_key :graphics, :issue
    remove_column :graphics, :issue_id
  end
end
