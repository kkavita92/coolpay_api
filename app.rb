require 'sinatra/base'
require 'net/http'
require 'uri'

class CoolPay < Sinatra::Base
  enable :sessions

  helpers do
    def token
      @token ||= session[:token]
    end
  end

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
    session[:token] = JSON.parse(response.body)['token']
    redirect to '/home'
  end

  get '/home' do  
    uri = URI.parse('https://coolpay.herokuapp.com/api/recipients')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri.request_uri, {'Content-Type': 'application/json'})
    req['Authorization'] = "Bearer #{token}"
    response = http.request(req)
    @recipients = JSON.parse(response.body)['recipients']
    erb :home
  end



  run! if app_file == $0
end
