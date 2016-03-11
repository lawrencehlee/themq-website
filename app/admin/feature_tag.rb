ActiveAdmin.register FeatureTag do

	permit_params :feature_id, :tag_id

	index do
		selectable_column
		column :feature_id
		column :tag_id
		actions
	end

	form do |f|
		f.inputs "Feature Tag Details" do
			f.input :feature_id
			f.input :tag_id
		end
		f.actions
	end

end
