ActiveAdmin.register ArticleTag do

	permit_params :article_id, :tag_id

	index do
		selectable_column
		column :article_id
		column :tag_id
		#actions
	end

	form do |f|
		f.inputs "Article Tag Details" do
			f.input :article_id
			f.input :tag_id
		end
		f.actions
	end

end
