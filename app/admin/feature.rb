ActiveAdmin.register Feature do

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


	permit_params :feature_id, :issue_id, :title, :image, :spread, :width, :height, :name

	index do
		selectable_column
		column :feature_id
		column :issue_id
		column :title
		column :image
		column :spread
		column :width
		column :height
    column :name
		actions
	end

	form do |f|
		f.inputs "Feature Details" do
			f.input :issue_id
			f.input :title
			f.input :image, as: :string
			f.input :spread, as: :string
			f.input :width
			f.input :height
      f.input :name
		end
		f.actions
	end
end
