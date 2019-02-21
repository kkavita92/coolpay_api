require 'sinatra/base'
require 'net/http'
require 'uri'

require_relative 'lib/request'
require_relative 'lib/http_client'
require_relative 'lib/api'

class CoolPay < Sinatra::Base
  enable :sessions

  helpers do
    def api
      @api = Api.new('https://coolpay.herokuapp.com/api')
    end

    def token
      @token ||= session[:token]
    end
  end

  get '/' do
    erb :index
  end

  post '/authenticate' do
    credentials = {
        "username": "",
        "apikey": ""
    }

    response = api.handle_post_request('/login', credentials)
    session[:token] = JSON.parse(response.body)['token']
    redirect to '/home'
  end

  get '/home' do
    response = api.handle_get_request('/recipients', token)
    @recipients = JSON.parse(response.body)['recipients']

    response = api.handle_get_request('/payments', token)
    @payments = JSON.parse(response.body)['payments']
    erb :home
  end

  post '/recipient' do
    body = {
      "recipient": {
        "name": params[:new_recipient]
      }
    }

    api.handle_post_request('/recipients?name=', body, token)
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

    api.handle_post_request('/payments', body, token)
    redirect to '/home'
  end

  run! if app_file == $0
end
