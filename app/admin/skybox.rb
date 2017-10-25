ActiveAdmin.register Skybox do

	permit_params :skybox_id, :issue_id, :text1, :text2, :image

	index do
		selectable_column
		column :skybox_id
		column :issue
		column :text1
		column :text2
		column :image
		actions
	end

	form do |f|
		f.inputs "Skybox Details" do
			f.input :issue
			f.input :text1
			f.input :text2
			f.input :image, as: :file
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:skybox]
      @skybox = Skybox.new(attrs)
      image = attrs[:image]

      unless image.nil?
        @skybox.image = image.original_filename
      end

      @skybox.save!

      # Don't upload image until skybox saves successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        SkyboxStorageAdapter.upload_skybox(@skybox.issue.volume_no, @skybox.issue.issue_no, @skybox.image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:skybox]
      @skybox = Skybox.find(resource.skybox_id)
      image = attrs[:image]

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:image] = image.original_filename
      end

      @skybox.update!(attrs)

      # Don't upload image until skybox updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        SkyboxStorageAdapter.upload_skybox(@skybox.issue.volume_no, @skybox.issue.issue_no, image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end
end
