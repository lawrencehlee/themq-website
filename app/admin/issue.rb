ActiveAdmin.register Issue do

	permit_params :issue_id, :volumn_no, :issue_no, :date, :staff_photo, :staff_photo_caption,
		:eic_not, :booster_club, :brief_title, :masthead, :celeb_quote, :celeb, :celeb_photo

	index do
		selectable_column
		column :issue_id
		column :volume_no
		column :issue_no
		column :date
		column :staff_photo
		column :staff_photo_caption
		column :eic_note
		column :booster_club
		column :brief_title
		column :masthead
		column :celeb_quote
		column :celeb
		column :celeb_photo
		actions
	end

	form do |f|
		f.inputs "Issue details" do
			f.input :volume_no
			f.input :issue_no
			f.input :date, as: :string
			f.input :staff_photo
			f.input :staff_photo_caption
			f.input :eic_note
			f.input :booster_club
			f.input :brief_title
			f.input :masthead
			f.input :celeb_quote
			f.input :celeb
			f.input :celeb_photo
		end
		f.actions
	end
end
