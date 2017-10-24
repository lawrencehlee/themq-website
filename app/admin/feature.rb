ActiveAdmin.register Feature do
  remove_filter :feature_tags

	permit_params :feature_id, :issue_id, :title, :image, :spread, :width, :height, :name,
    feature_tags_attributes: [:id, :tag_id, :_destroy]

	index do
		selectable_column
		column :feature_id
		column :issue
		column :title
		column :image
		column :spread
		column :width
		column :height
    column :name
		actions
	end

	form do |f|
		f.inputs "Feature Details" do
			f.input :issue
			f.input :title
			f.input :image, as: :file
			f.input :spread
			f.input :width
			f.input :height

      f.inputs "Feature Tags" do
        f.has_many :feature_tags, allow_destroy: true, new_record: true do |t|
          t.input :tag
        end
      end
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:feature]
      @feature = Feature.new(attrs)
      image = attrs[:image]

      unless image.nil?
        @feature.image = image.original_filename
        @feature.name = image.original_filename.split(".jpg").first
      end

      @feature.save!

      # Don't upload image until feature saves successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        FeatureStorageAdapter.upload_feature(@feature.issue.volume_no, @feature.issue.issue_no, @feature.image, image.open)
      end

      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:feature]
      @feature = Feature.find(resource.feature_id)
      image = attrs[:image]

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:image] = image.original_filename
        attrs[:name] = image.original_filename.split(".jpg").first
      end

      @feature.update!(attrs)

      # Don't upload image until feature updates successfully
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        FeatureStorageAdapter.upload_feature(@feature.issue.volume_no, @feature.issue.issue_no, image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end
end
