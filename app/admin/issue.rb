ActiveAdmin.register Issue do
  remove_filter :current

  permit_params :issue_id, :volume_no, :issue_no, :sub_issue_no, :date, :staff_photo,
    :staff_photo_caption, :eic_note, :booster_club, :brief_title, :masthead, :celeb_quote, :celeb,
    :celeb_photo, :current, :issuu_link

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
    column :issuu_link
    actions
  end

  form do |f|
    f.inputs "Issue details" do
      f.input :volume_no
      f.input :issue_no
      f.input :sub_issue_no
      f.input :date, as: :datepicker
      f.input :staff_photo, as: :file
      f.input :staff_photo_caption
      f.input :eic_note
      f.input :booster_club
      f.input :brief_title
      f.input :masthead
      f.input :celeb_quote
      f.input :celeb
      f.input :celeb_photo, as: :file
      f.input :issuu_link
      f.input :current
    end
    f.actions
  end

  controller do
    def create
      attrs = permitted_params[:issue]
      @issue = Issue.new(attrs)
      staff_photo = attrs[:staff_photo]
      celeb_photo = attrs[:celeb_photo]

      unless staff_photo.nil?
        @issue.staff_photo = staff_photo.original_filename
      end
      unless celeb_photo.nil?
        @issue.celeb_photo = celeb_photo.original_filename
      end

      @issue.save!

      # Don't upload images until issue saves successfully
      unless staff_photo.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        IssueStorageAdapter.upload_photo(@issue.volume_no, @issue.issue_no, @issue.staff_photo, staff_photo.open)
      end
      unless celeb_photo.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        IssueStorageAdapter.upload_photo(@issue.volume_no, @issue.issue_no, @issue.celeb_photo, celeb_photo.open)
      end

      redirect_to resource_url
    end

    def update
      attrs = permitted_params[:issue]
      @issue = Issue.find(resource.issue_id)
      staff_photo = attrs[:staff_photo]
      celeb_photo = attrs[:celeb_photo]

      unless staff_photo.nil?
        attrs[:staff_photo] = staff_photo.original_filename
      end
      unless celeb_photo.nil?
        attrs[:celeb_photo] = celeb_photo.original_filename
      end

      @issue.update!(attrs)

      # Don't upload images until issue saves successfully
      unless staff_photo.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        IssueStorageAdapter.upload_photo(@issue.volume_no, @issue.issue_no, staff_photo.original_filename, staff_photo.open)
      end
      unless celeb_photo.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        IssueStorageAdapter.upload_photo(@issue.volume_no, @issue.issue_no, celeb_photo.original_filename, celeb_photo.open)
      end

      redirect_to resource_url
    end
  end
end
