ActiveAdmin.register TopTenEntry do

	permit_params :top_ten_entry_id, :top_ten_id, :text, :entry_no

	index do
		selectable_column
		column :top_ten_entry_id
		column :top_ten
		column :text
		column :entry_no
		actions
	end

	form do |f|
		f.inputs "Top Ten Entry Details" do
			f.input :top_ten
			f.input :text
			f.input :entry_no
		end
		f.actions
	end

end
