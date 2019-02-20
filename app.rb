require 'sinatra/base'
require 'net/http'
require 'uri'

require_relative 'lib/request'
require_relative 'lib/http_client'

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
    client = HTTPClient.new('https://coolpay.herokuapp.com/api/login')
    req = Request.build_post(client.request_uri, credentials.to_json)
    response = client.handle_request(req)
    session[:token] = JSON.parse(response.body)['token']
    redirect to '/home'
  end

  get '/home' do
    client = HTTPClient.new('https://coolpay.herokuapp.com/api/recipients')
    req = Request.build_get(client.request_uri, token)
    response = client.handle_request(req)
    @recipients = JSON.parse(response.body)['recipients']

    client = HTTPClient.new('https://coolpay.herokuapp.com/api/payments')
    req = Request.build_get(client.request_uri, token)
    response = client.handle_request(req)
    @payments = JSON.parse(response.body)['payments']
    erb :home
  end

  post '/recipient' do
    body = {
      "recipient": {
        "name": params[:new_recipient]
      }
    }

    client = HTTPClient.new("https://coolpay.herokuapp.com/api/recipients?name=")
    req = Request.build_post(client.request_uri, body.to_json, token)
    response = client.handle_request(req)
    redirect to '/home'
  end

  post '/payment' do
    body = {
      "payment": {
        "amount": params[:amount],
        "currency": "GBP",
        "recipient_id": params[:id]
      }
    }

    client = HTTPClient.new("https://coolpay.herokuapp.com/api/payments")
    req = Request.build_post(client.request_uri, body.to_json, token)
    esponse = client.handle_request(req)
    redirect to '/home'
  end

  run! if app_file == $0
end
