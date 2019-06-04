# Weather Forecast App

Simple app that allows users tracking weather in choosen locations. Forecast are fetched from OpenWeatherMap API.

## Tech stack
- Ruby 2.6.2
- Rails 5.2.3

## How to run?
1. Clone repository.
2. Run `$ bundle install`
3. Copy `database.sample.yml` to `database.yml` and make changes if necessary.
4. Copy `.env.sample` to `.env` and provide credentials
5. Run `$ rails import_locations` (it may take a while - ~200k records are imported)
6. Run `$ rails s` 
## Features
- creating accounts
- location management by user
- browsing all available locations provided by OpenWeatherMap API
- fetching foreacst from OpenWeatherMap API
- caching results fetched from API by Redis
