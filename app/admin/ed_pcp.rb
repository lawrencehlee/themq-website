ActiveAdmin.register EdPcp do

	permit_params :ed_pcp_id, :issue_id, :ed, :point, :counterpoint, :crspnd_point_id,
		:headline, :author, :author_title, :author_image, :text, :title

	index do
		selectable_column
		column :ed_pcp_id
		column :issue_id
		column :ed
		column :point
		column :counterpoint
		column :crspnd_point_id
		column :headline
		column :author
		column :author_title
		column :author_image
		column :text
		column :title
		actions
	end

	form do |f|
		f.inputs "EdPcp Details" do
			f.input :issue_id
			f.input :ed, as: :string
			f.input :point, as: :string
			f.input :counterpoint, as: :string
			f.input :crspnd_point_id
			f.input :headline
			f.input :author
			f.input :author_title
			f.input :author_image
			f.input :text
			f.input :title
		end
		f.actions
	end
end
