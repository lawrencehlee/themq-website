ActiveAdmin.register EdPcp do

  remove_filter :ed_pcp_tags

	permit_params :ed_pcp_id, :issue_id, :ed, :point, :counterpoint, :crspnd_point_id,
		:headline, :author, :author_title, :author_image, :text, :title,
    ed_pcp_tags_attributes: [:id, :tag_id, :_destroy]

	index do
		selectable_column
		column :ed_pcp_id
		column :issue
		column :ed
		column :point
		column :counterpoint
		column :crspnd_point
		column :headline
		column :author
		column :author_title
		column :author_image
		column :text
		column :title
		actions
	end

	form do |f|
		f.inputs "Ed/PCP Details" do
			f.input :issue
			f.input :ed
			f.input :point
			f.input :counterpoint
			f.input :crspnd_point
			f.input :headline
			f.input :author
			f.input :author_title
			f.input :author_image, as: :file
			f.input :text, as: :file

      f.inputs "Ed/PCP Tags" do
        f.has_many :ed_pcp_tags, allow_destroy: true, new_record: true do |t|
          t.input :tag
        end
      end
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:ed_pcp]
      @ed_pcp = EdPcp.new(attrs)
      ed_pcp_text = attrs[:text]
      image = attrs[:author_image]

      unless ed_pcp_text.nil?
        @ed_pcp.text = ed_pcp_text.original_filename
        @ed_pcp.title = @ed_pcp.text.split(".md").first # Set the title to be just the filename without extension
      end
      unless image.nil?
        @ed_pcp.author_image = image.original_filename
      end

      @ed_pcp.save!

      # Don't upload stuff until ed/pcp saves successfully
      unless ed_pcp_text.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        EdPcpStorageAdapter.upload_ed_pcp_text(@ed_pcp.issue.volume_no, @ed_pcp.issue.issue_no, @ed_pcp.text, ed_pcp_text.open)
      end
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        EdPcpStorageAdapter.upload_ed_pcp_image(@ed_pcp.issue.volume_no, @ed_pcp.issue.issue_no, @ed_pcp.author_image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:ed_pcp]
      @ed_pcp = EdPcp.find(resource.ed_pcp_id)
      ed_pcp_text = attrs[:text]
      image = attrs[:author_image]

      unless ed_pcp_text.nil?
        attrs[:text] = ed_pcp_text.original_filename
        attrs[:title] = attrs[:text].split(".md").first # Set the title to be just the filename without extension
      end
      unless image.nil?
        attrs[:author_image] = image.original_filename
      end

      @ed_pcp.update!(attrs)

      # Don't upload image until self ad updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        EdPcpStorageAdapter.upload_ed_pcp(@ed_pcp.issue.volume_no, @ed_pcp.issue.issue_no, image.original_filename, image.open)
      end


      # Don't upload stuff until ed/pcp saves successfully
      unless ed_pcp_text.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        EdPcpStorageAdapter.upload_ed_pcp_text(@ed_pcp.issue.volume_no, @ed_pcp.issue.issue_no, ed_pcp_text.original_filename, ed_pcp_text.open)
      end
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        EdPcpStorageAdapter.upload_ed_pcp_image(@ed_pcp.issue.volume_no, @ed_pcp.issue.issue_no, image.original_filename, image.open)
      end
      redirect_to resource_url
    end
  end
end
