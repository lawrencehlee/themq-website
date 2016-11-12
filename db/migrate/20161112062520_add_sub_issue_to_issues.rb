class AddSubIssueToIssues < ActiveRecord::Migration
  def change
    change_table :issues do |t|
      t.integer "sub_issue_no"
      t.binary "current", null: false
    end
  end
end
