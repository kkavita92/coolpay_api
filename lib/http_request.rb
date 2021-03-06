require 'net/http'

class HTTPRequest
  CONTENT_TYPE_HEADER = {'Content-Type': 'application/json'}

  def self.build_post(request_uri, body, token)
    req = Net::HTTP::Post.new(request_uri, CONTENT_TYPE_HEADER)
    req.body = body.to_json
    self.set_token(req, token)
    req
  end

  def self.build_get(request_uri, token)
    req = Net::HTTP::Get.new(request_uri, CONTENT_TYPE_HEADER)
    self.set_token(req, token)
    req
  end

  private

  def self.set_token(req, token)
    req['Authorization'] = "Bearer #{token}" unless token.nil?
  end
end
