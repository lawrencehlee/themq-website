ActiveAdmin.register Issue do

  permit_params :issue_id, :volume_no, :issue_no, :sub_issue_no, :date, :staff_photo,
    :staff_photo_caption, :eic_note, :booster_club, :brief_title, :masthead, :celeb_quote, :celeb,
    :celeb_photo, :current

  index do
    selectable_column
    column :issue_id
    column :volume_no
    column :issue_no
    column :sub_issue_no
    column :date
    column :staff_photo
    column :brief_title
    column :masthead
    column :celeb_quote
    column :celeb
    column :celeb_photo
    column :current
    actions
  end

  form do |f|
    f.inputs "Issue details" do
      f.input :volume_no
      f.input :issue_no
      f.input :sub_issue_no
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
      f.input :current, as: :string
    end
    f.actions
  end
end
