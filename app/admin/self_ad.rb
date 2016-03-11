ActiveAdmin.register SelfAd do

	permit_params :self_ad_id, :issue_id, :text, :image

	index do
		selectable_column
		column :self_ad_id
		column :issue_id
		column :text
		column :image
		actions
	end

	form do |f|
		f.inputs "Self Ad Details" do
			f.input :issue_id
			f.input :text
			f.input :image, as: :string
		end
		f.actions
	end

end
