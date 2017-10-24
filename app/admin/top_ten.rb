ActiveAdmin.register TopTen do
  remove_filter :top_ten_entries

	permit_params :top_ten_id, :issue_id, :title, :no_of_entries, top_ten_entries_attributes: [:id, :text, :entry_no, :_destroy]

	index do
		selectable_column
		column :top_ten_id
		column :issue
		column :title
		column :no_of_entries
		actions
	end

	form do |f|
		f.inputs "Top Ten Details" do
			f.input :issue
			f.input :title
			f.input :no_of_entries

      f.inputs "Entries" do
        f.has_many :top_ten_entries, allow_destroy: true, new_record: true do |t|
          t.input :entry_no
          t.input :text
        end
      end
		end
		f.actions
	end
end
