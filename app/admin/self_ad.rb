ActiveAdmin.register SelfAd do

	permit_params :self_ad_id, :issue_id, :image

	index do
		selectable_column
		column :self_ad_id
		column :issue
		column :image
		actions
	end

	form do |f|
		f.inputs "Self Ad Details" do
			f.input :issue
			f.input :image, as: :file
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:self_ad]
      @self_ad = SelfAd.new(attrs)
      image = attrs[:image]

      unless image.nil?
        @self_ad.image = image.original_filename
      end

      @self_ad.save!

      # Don't upload image until self ad saves successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        SelfAdStorageAdapter.upload_self_ad(@self_ad.issue.volume_no, @self_ad.issue.issue_no, @self_ad.image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:self_ad]
      @self_ad = SelfAd.find(resource.self_ad_id)
      image = attrs[:image]

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:image] = image.original_filename
      end

      @self_ad.update!(attrs)

      # Don't upload image until self ad updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        SelfAdStorageAdapter.upload_self_ad(@self_ad.issue.volume_no, @self_ad.issue.issue_no, image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end

end
