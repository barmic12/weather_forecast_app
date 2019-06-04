# frozen_string_literal: true

require 'rails_helper'
module StubHelper
  def stub_current_weather(location)
    api_key = Faker::Lorem.characters(10)
    OpenWeatherMap::CurrentWeather.new(api_key)
    endpoint = "https://api.openweathermap.org/data/2.5/weather?APPID=#{api_key}&id=#{location.api_id}"
    stubbed_json = CurrentWeatherFactory.by_city_id(location.api_id)
    stub_request(:get, endpoint).
      with(
         headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
         }).
      to_return(status: 200,
                body: stubbed_json,
                headers: {'Content-Type'=> 'application/json'})
  end
end
