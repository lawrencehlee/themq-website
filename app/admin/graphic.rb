ActiveAdmin.register Graphic do

	permit_params :graphic_id, :article_id, :person_id, :image, :caption

	index do
		selectable_column
		column :graphic_id
		column :article_id
		column :person_id
		column :image
		column :caption
		actions
	end

	form do |f|
		f.inputs "Graphics Details" do
			f.input :article_id
			f.input :person_id
			f.input :image, as: :file
			f.input :caption
		end
		f.actions
	end


  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:graphic]
      @graphic = Graphic.new(attrs)
      image = attrs[:image]

      unless image.nil?
        @graphic.image = image.original_filename
      end

      @graphic.save!

      # Don't upload image until graphic saves successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        GraphicStorageAdapter.upload_graphic(@graphic.article.issue.volume_no, @graphic.article.issue.issue_no, @graphic.image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:graphic]
      @graphic = Graphic.find(resource.graphic_id)
      image = attrs[:image]

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:image] = image.original_filename
      end

      @graphic.update!(attrs)

      # Don't upload image until graphic updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        GraphicStorageAdapter.upload_graphic(@graphic.article.issue.volume_no, @graphic.article.issue.issue_no, image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end
end
