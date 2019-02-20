require 'net/http'
require 'uri'

class HTTPClient

  def initialize(url)
    @uri = URI.parse(url)
    @http = http
  end

  def request_uri
    @uri.request_uri
  end

  def handle_request(request)
    @http.request(request)
  end

  private

  def http
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http
  end

end
