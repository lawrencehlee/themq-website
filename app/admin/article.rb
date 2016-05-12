ActiveAdmin.register Article do

	# find record with slug (friendly id)
	controller do
		def find_resource
			begin
				scoped_collection.where(slug: params[:id]).first!
			rescue ActiveRecord::RecordNotFound
				scoped_collection.find(params[:id])
			end
		end
	end


	permit_params :article_id, :person_id, :graphic_id, :issue_id, :headline, :text, :brief, :title

	index do
		selectable_column
		column :article_id
		column :person_id
		column :graphic_id
		column :issue_id
		column :headline
		column :text
		column :brief
		column :title
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
			f.input :title
		end
		f.actions
	end

end
