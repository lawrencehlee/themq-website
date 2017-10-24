class MakeTopTenEntryFkOnCascadeDelete < ActiveRecord::Migration
  def change
    remove_foreign_key :top_ten_entries, :top_ten
    TopTenEntry.connection.execute("ALTER TABLE top_ten_entries ADD CONSTRAINT `fk_top_ten_entries_top_ten` FOREIGN KEY (`top_ten_id`) REFERENCES top_tens (`top_ten_id`) ON DELETE CASCADE;")
  end
end
