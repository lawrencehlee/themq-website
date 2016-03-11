ActiveAdmin.register Feature do

	permit_params :feature_id, :issue_id, :title, :image, :spread

	index do
		selectable_column
		column :feature_id
		column :issue_id
		column :title
		column :image
		column :spread
		actions
	end

	form do |f|
		f.inputs "Feature Details" do
			f.input :issue_id
			f.input :title
			f.input :image, as: :string
			f.input :spread, as: :string
		end
		f.actions
	end
end
