require 'sinatra/base'
require 'net/http'
require 'uri'

require_relative 'lib/request'

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
    req = Request.build_post(uri.request_uri, credentials.to_json)
    response = http.request(req)
    session[:token] = JSON.parse(response.body)['token']
    redirect to '/home'
  end

  get '/home' do
    uri = URI.parse('https://coolpay.herokuapp.com/api/recipients')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Request.build_get(uri.request_uri, token)
    response = http.request(req)
    @recipients = JSON.parse(response.body)['recipients']

    uri = URI.parse('https://coolpay.herokuapp.com/api/payments')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Request.build_get(uri.request_uri, token)
    response = http.request(req)
    @payments = JSON.parse(response.body)['payments']
    erb :home
  end

  post '/recipient' do
    body = {
      "recipient": {
        "name": params[:new_recipient]
      }
    }

    uri = URI.parse("https://coolpay.herokuapp.com/api/recipients?name=")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Request.build_post(uri.request_uri, body.to_json, token)
    response = http.request(req)
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

    uri = URI.parse("https://coolpay.herokuapp.com/api/payments")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Request.build_post(uri.request_uri, body.to_json, token)
    response = http.request(req)
    redirect to '/home'
  end

  run! if app_file == $0
end
