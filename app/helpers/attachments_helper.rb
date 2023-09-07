module AttachmentsHelper
  def attachment_url(file)
    Rails.application.routes.url_helpers.rails_blob_url(file, host: 'localhost')
  end
end
