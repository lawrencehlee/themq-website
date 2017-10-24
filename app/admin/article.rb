ActiveAdmin.register Article do

  remove_filter :graphic, :article_tags
	permit_params :article_id, :author_id, :issue_id, :headline, :text, :title, :brief, :co_author_id,
    graphic_attributes: [:id, :person_id, :caption, :image, :_destroy], # Needs :_destroy to allow deletion
    article_tags_attributes: [:id, :tag_id, :_destroy]

	index do
		selectable_column
		column :article_id
		column :author
    column :co_author
		column :issue
		column :headline
		column :text
		column :brief
		actions
	end

	form do |f|
		f.inputs "Article Details" do
			f.input :author
      f.input :co_author
			f.input :issue
			f.input :headline
			f.input :text, as: :file
			f.input :brief

      f.inputs "Graphic Details" do
        f.has_many :graphic, allow_destroy: true, new_record: "ONLY ADD ONE GRAPHIC!" do |g|
          g.input :person_id
          g.input :caption
          g.input :image, as: :file
        end
      end

      f.inputs "Article Tags" do
        f.has_many :article_tags, allow_destroy: true, new_record: true do |t|
          t.input :tag
        end
      end
		end
		f.actions
	end

  controller do
    # Custom create method to upload images to cloud storage
    def create
      attrs = permitted_params[:article]
      @article = Article.new(attrs)
      article_text = attrs[:text]
      image = nil
      unless attrs[:graphic_attributes].nil?
        image = attrs[:graphic_attributes][:image]
      end

      unless article_text.nil?
        @article.text = article_text.original_filename
        @article.title = @article.text.split(".md").first # Set the title to be just the filename without extension
      end

      # No brief check because, while briefs currently don't have graphic, nothing really prevents them from doing so
      unless image.nil?
        @graphic = @article.graphic
        @graphic.image = image.original_filename
      end

      # Save both article and graphic
      @article.save!

      # Don't upload stuff until article saves successfully
      unless article_text.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        ArticleStorageAdapter.upload_article(@article.issue.volume_no, @article.issue.issue_no, @article.text, article_text.open)
      end
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        GraphicStorageAdapter.upload_graphic(@article.issue.volume_no, @article.issue.issue_no, @graphic.image, image.open)
      end

      # Somehow resource is defined only if @article is an instance variable
      redirect_to resource_url
    end

    # Custom update method to upload images to cloud storage
    def update
      attrs = permitted_params[:article]
      @article = Article.find(resource.article_id)
      article_text = attrs[:text]
      image = nil
      unless attrs[:graphic_attributes].nil?
        image = attrs[:graphic_attributes][:image]
      end

      # If there's an uploaded article, it's probably new, so update the name
      unless article_text.nil?
        attrs[:text] = article_text.original_filename
        attrs[:title] = attrs[:text].split(".md").first # Set the title to be just the filename without extension
      end

      # If there's an uploaded image, it's probably new, so update the name
      unless image.nil?
        attrs[:graphic_attributes][:image] = image.original_filename
      end

      @article.update!(attrs)

      # Don't upload image until article updates successfully
      unless article_text.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        ArticleStorageAdapter.upload_article(@article.issue.volume_no, @article.issue.issue_no, article_text.original_filename, article_text.open)
      end
      unless image.nil?
        # Takes the StringIO version of the image, which is why we call image.open
        GraphicStorageAdapter.upload_graphic(@article.issue.volume_no, @article.issue.issue_no, image.original_filename, image.open)
      end

      redirect_to resource_url
    end
  end
end
