ActiveAdmin.register TopTenTag do

	permit_params :top_ten_id, :tag_id

	index do
		selectable_column
		column :top_ten_id
		column :tag_id
		actions
	end

	form do |f|
		f.inputs "Top Ten Tag Details" do
			f.input :top_ten_id
			f.input :tag_id
		end
		f.actions
	end

end
