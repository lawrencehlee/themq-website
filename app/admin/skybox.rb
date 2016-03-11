ActiveAdmin.register Skybox do

	permit_params :skybox_id, :issue_id, :text1, :text2, :image

	index do
		selectable_column
		column :skybox_id
		column :issue_id
		column :text1
		column :text2
		column :image
		actions
	end

	form do |f|
		f.inputs "Skybox Details" do
			f.input :issue_id
			f.input :text1
			f.input :text2
			f.input :image, as: :string
		end
		f.actions
	end
end
