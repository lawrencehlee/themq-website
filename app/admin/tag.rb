ActiveAdmin.register Tag do

	permit_params :tag_id, :title

	index do
		selectable_column
		column :tag_id
		column :title
		actions
	end

	form do |f|
		f.inputs "Tag Details" do
			f.input :title
		end
		f.actions
	end

end
