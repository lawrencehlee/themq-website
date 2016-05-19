ActiveAdmin.register TopTen do

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



	permit_params :top_ten_id, :issue_id, :title, :no_of_entries

	index do
		selectable_column
		column :top_ten_id
		column :issue_id
		column :title
		column :no_of_entries
		actions
	end

	form do |f|
		f.inputs "Top Ten Details" do
			f.input :issue_id
			f.input :title
			f.input :no_of_entries
		end
		f.actions
	end
end
