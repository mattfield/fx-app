require 'json'
require 'sinatra'
require 'exchange_rate'

ENV["XML_FEED_PATH"] = 'public/data/feed.xml'

def rates_by_date(date = Date.today)
  ECBQuote.new({ 'date' => date, 'from' => 'EUR', 'to' => 'EUR'}).rates
end

def rates_all
  rates = []
  ECBFeed.new().each { |rate| rates << rate }
  rates
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
  amount = params['amount'].to_f
  from = params['from']
  to = params['to']

  (round(amount * ExchangeRate.at(Date.today, "#{from}", "#{to}"))).to_s
end
