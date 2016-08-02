ActiveAdmin.register Person do
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

	permit_params :person_id, :position_id, :name, :bio, :image, :current, :quote

	index do
		selectable_column
		column :person_id
		column :position_id
		column :name
		column :bio
    column :quote
		column :image
		column :current
		actions
	end

	form do |f|
		f.inputs "Person Details" do
			f.input :position_id
			f.input :name
			f.input :bio
      f.input :quote
			f.input :image
			f.input :current, as: :string
		end
		f.actions
	end

end
