ActiveAdmin.register Graphic do

	permit_params :graphic_id, :article_id, :person_id, :image, :caption

	index do
		selectable_column
		column :graphic_id
		column :article_id
		column :person_id
		column :image
		column :caption
		actions
	end

	form do |f|
		f.inputs "Graphics Details" do
			f.input :article_id
			f.input :person_id
			f.input :image
			f.input :caption
		end
		f.actions
	end

end
