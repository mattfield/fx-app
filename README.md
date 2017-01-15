# FX-App

Small Sinatra app and API utilising https://github.com/mattfield/exchange_rate to calculate exchange ranges.

## Installation

1. Clone the repo
1. Run `bundle` to grab gems
1. `bundle exec ruby app.rb`
1. Go to `localhost:4567`

## Application routes

`path: /`
Renders the homepage

`path: /convert/?amount=:amount&from=:from&to=:to`
Calculates conversion of `amount` from `from` currency to `to` currency

`path: /rates/?`
Redirects to `/rates/all/?`

`path: /rates/all/?`
Prints an Array of the whole available ECB feed in format: `{ :date => String(xmlschema-formatted), :iso => String, :rate => Float }`

`path: /rates/:date`
Prints a Hash of currencies and rates for the given date in format: `{ currency<String>, rate<String> }`
