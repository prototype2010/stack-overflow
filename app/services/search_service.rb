class SearchService
  ALLOWED_SEARCH_CLASSES = %w[Question Answer Comment]

  def initialize(params)
    @params = params
    @results = []
  end

  def call
    if @params['search_everywhere']
      search_everywhere
    else
      search_by_selected_entities
    end
  end

  private

  def search_by_selected_entities
    ALLOWED_SEARCH_CLASSES.each_with_object([]) do |class_name, results|
      results.concat(class_name.constantize.search(@params[:text]).to_a) if @params[class_name]
    end
  end

  def search_everywhere
    PgSearch.multisearch(@params[:text]).to_a.map(&:searchable)
  end
end
