ActiveAdmin.register Person do

	permit_params :person_id, :position_id, :name, :bio, :image, :current

	index do
		selectable_column
		column :person_id
		column :position_id
		column :name
		column :bio
		column :image
		column :current
		actions
	end

	form do |f|
		f.inputs "Person Details" do
			f.input :position_id
			f.input :name
			f.input :bio
			f.input :image
			f.input :current, as: :string
		end
		f.actions
	end

end
