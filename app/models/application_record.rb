class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  after_save :update_search_indices

  def update_search_indices
    update_pg_search_document
  end
end
