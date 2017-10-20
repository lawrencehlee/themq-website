ActiveAdmin.register Article do

  remove_filter :graphic

	permit_params :article_id, :author_id, :issue_id, :headline, :text, :brief, :title, :co_author_id

	index do
		selectable_column
		column :article_id
		column :author_id
    column :co_author_id
		column :issue_id
		column :headline
		column :text
		column :brief
		column :title
		actions
	end

	form do |f|
		f.inputs "Article Details" do
			f.input :author_id
      f.input :co_author_id
			f.input :issue_id
			f.input :headline
			f.input :text
			f.input :brief, as: :string
			f.input :title
		end
		f.actions
	end

end
