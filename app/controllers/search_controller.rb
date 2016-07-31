class SearchController < ApplicationController
  SEARCHABLE_MODELS = [Article, EdPcp, Graphic, Person,
                       Feature, TopTen, TopTenEntry]

  def index
		@query = params[:query]

    unless @query.blank?
      @search = Sunspot.search(SEARCHABLE_MODELS) do
        fulltext params[:query]
        paginate(page: params[:page], :per_page => 10)
      end
      @results = @search.results
    end
  end
end
