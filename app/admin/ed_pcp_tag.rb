ActiveAdmin.register EdPcpTag do

	permit_params :ed_pcp_id, :tag_id

	index do
		selectable_column
		column :ed_pcp_id
		column :tag_id
		actions
	end

	form do |f|
		f.inputs "Ed Pcp Tag Details" do
			f.input :ed_pcp_id
			f.input :tag_id
		end
		f.actions
	end

end
