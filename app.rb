require 'json'
require 'sinatra'
require 'exchange_rate'

ENV["XML_FEED_PATH"] = 'public/data/feed.xml'

def rates_by_date(date = Date.today)
  ExchangeRate.all_rates_at(date = Date.today)
end

def rates_all
  ExchangeRate.all_rates
end

def round value
  Float(format('%.7g', value))
end

get '/' do
  @currencies_for_date = rates_by_date

  haml :index
end

get '/rates/?' do
  redirect to "/rates/all"
end

get '/rates/all/?' do
  rates_all.to_json
end

get '/rates/:date' do
  rates_by_date("#{params['date']}").to_json
end

get '/convert/?' do
  date = params['date'] ? params['date'] : Date.today
  amount = params['amount'].to_f
  from = params['from']
  to = params['to']

  (round(amount * ExchangeRate.at(date, "#{from}", "#{to}"))).to_s
end
