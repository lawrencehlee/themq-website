ActiveAdmin.register Feature do

	permit_params :feature_id, :issue_id, :title, :image, :spread, :width, :height, :name

	index do
		selectable_column
		column :feature_id
		column :issue_id
		column :title
		column :image
		column :spread
		column :width
		column :height
    column :name
		actions
	end

	form do |f|
		f.inputs "Feature Details" do
			f.input :issue_id
			f.input :title
			f.input :image, as: :string
			f.input :spread, as: :string
			f.input :width
			f.input :height
      f.input :name
		end
		f.actions
	end
end
