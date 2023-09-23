class SearchController < ApplicationController
  def index;end

  def search
    @results = SearchService.new(search_params).call
  end

  private

  def search_params
    params.permit(:text, :search_everywhere, :Question, :Answer, :Comment)
  end
end
