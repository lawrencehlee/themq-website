class TopTen < ActiveRecord::Base

    def get_entries
        TopTenEntry.where(top_ten_id: self.top_ten_id).order("entry_no desc")
    end
end
