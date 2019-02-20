require 'sinatra/base'
require 'net/http'
require 'uri'

class CoolPay < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/authenticate' do
    credentials = {
        "username": ENV['USERNAME'],
        "apikey": ENV['API_KEY']
    }
    uri = URI.parse('https://coolpay.herokuapp.com/api/login')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri, {'Content-Type': 'application/json'})
    req.body = credentials.to_json
    response = http.request(req)
    redirect to '/home'
  end

  get '/home' do
    'Welcome!'
  end



  run! if app_file == $0
end
