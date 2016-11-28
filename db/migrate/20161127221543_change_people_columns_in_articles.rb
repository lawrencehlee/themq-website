class ChangePeopleColumnsInArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.rename :person_id, :author_id
      t.rename :co_author, :co_author_id
    end
  end
end
