ActiveAdmin.register Person do
	permit_params :person_id, :position_id, :name, :bio, :image, :current, :quote

	index do
		selectable_column
		column :person_id
		column :position
		column :name
		column :bio
    column :quote
		column :image
		column :current
		actions
	end

	form do |f|
		f.inputs "Person Details" do
			f.input :position
			f.input :name
			f.input :bio
      f.input :quote
			f.input :image, as: :file
			f.input :current
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:person]
      @person = Person.new(attrs)
      image = attrs[:image]

      unless image.nil?
        @person.image = image.original_filename
      end

      @person.save!

      # Don't upload image until person saves successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        PersonStorageAdapter.upload_editor_photo(@person.image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:person]
      @person = Person.find(resource.person_id)
      image = attrs[:image]

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:image] = image.original_filename
      end

      @person.update!(attrs)

      # Don't upload image until person updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        PersonStorageAdapter.upload_editor_photo(image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end

end
