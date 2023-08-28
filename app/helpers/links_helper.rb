module LinksHelper
  GIST_REGEXP = %r{^https://gist.github.com/[a-zA-Z0-9]*/[a-zA-Z0-9]*$}.freeze
  GIST_ID_REGEXP = %r{^*.*/([a-zA-Z0-9]*)$}.freeze

  def gist_url?(url)
    GIST_REGEXP.match?(url)
  end

  def gist_id(url)
    url.match(GIST_ID_REGEXP)[1]
  end
end
