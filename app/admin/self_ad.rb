ActiveAdmin.register SelfAd do

	permit_params :self_ad_id, :issue_id, :image

	index do
		selectable_column
		column :self_ad_id
		column :issue_id
		column :image
		actions
	end

	form do |f|
		f.inputs "Self Ad Details" do
			f.input :issue_id
			f.input :image, as: :string
		end
		f.actions
	end

end
