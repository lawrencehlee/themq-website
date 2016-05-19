ActiveAdmin.register Tag do

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



	permit_params :tag_id, :title

	index do
		selectable_column
		column :tag_id
		column :title
		actions
	end

	form do |f|
		f.inputs "Tag Details" do
			f.input :title
		end
		f.actions
	end

end
