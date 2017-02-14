ActiveAdmin.register Position do

	permit_params :title, :editor

	index do
		selectable_column
		column :position_id
		column :title
    column :editor
		actions
	end

	form do |f|
		f.inputs "Position Details" do
			f.input :title
      f.input :editor
		end
		f.actions
	end

end
