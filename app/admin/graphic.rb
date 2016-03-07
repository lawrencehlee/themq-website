ActiveAdmin.register Graphic do

	permit_params :article_id, :person_id, :issue_id, :image, :caption

	index do
		selectable_column
		column :graphic_id
		column :article_id
		column :person_id
		column :issue_id
		column :image
		column :caption
		actions
	end

	form do |f|
		f.inputs "Graphics Details" do
			f.input :graphic_id
			f.input :article_id
			f.input :person_id
			f.input :issue_id
			f.input :image
			f.input :caaption
		end
		f.actions
	end

end
