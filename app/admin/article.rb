ActiveAdmin.register Article do

	permit_params :article_id, :person_id, :graphic_id, :issue_id, :headline, :text, :brief

	index do
		selectable_column
		column :article_id
		column :person_id
		column :graphic_id
		column :issue_id
		column :headline
		column :text
		column :brief
		actions
	end

	form do |f|
		f.inputs "Article Details" do
			f.input :person_id
			f.input :graphic_id
			f.input :issue_id
			f.input :headline
			f.input :text
			f.input :brief, as: :string
		end
		f.actions
	end

end
