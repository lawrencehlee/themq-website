ActiveAdmin.register Position do

	permit_params :title

	index do
		selectable_column
		column :position_id
		column :title
		actions
	end

	form do |f|
		f.inputs "Position Details" do
			f.input :title
		end
		f.actions
	end

end
