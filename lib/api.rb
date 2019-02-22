require_relative './request'
require_relative './http_client'
require_relative './credentials'

class Api
  attr_accessor :credentials
  
  def initialize (api_url, http_client = HTTPClient, request = Request, credentials = Credentials)
    @url = api_url
    @http_client = http_client
    @request = request
    @credentials = credentials.fetch
  end

  def handle_get_request(path, token=nil)
    client = build_url(path)
    req = @request.build_get(client.request_uri, token)
    response = client.handle_request(req)
  end

  def handle_post_request(path, body=nil, token=nil)
    client = build_url(path)
    req = @request.build_post(client.request_uri, body, token)
    response = client.handle_request(req)
  end

  private

  def build_url(path)
    @http_client.new(@url + path)
  end

end
