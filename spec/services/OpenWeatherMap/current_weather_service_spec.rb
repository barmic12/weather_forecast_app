# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Current Weather API request' do
  include ActiveSupport::Testing::TimeHelpers
  include CurrentWeatherFactory
  describe 'city_by_id' do
    let(:location) { create(:location) }
    let(:api_key) { Faker::Lorem.characters(10)}
    let(:api) { OpenWeatherMap::CurrentWeather.new(api_key) }
    let(:endpoint) { "https://api.openweathermap.org/data/2.5/weather?APPID=#{api_key}&id=#{location.api_id}" }
    before do
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

    it 'returns data for given city' do
      data = api.city_by_id(location.api_id)
      expect(data.id).to eq(location.api_id.to_s)
    end

    it 'saves result to cache' do
      data = api.city_by_id(location.api_id)
      expect(Rails.cache.read("city_weather/#{location.api_id}")).to_not be_nil
    end

    it 'keep cache for an hour' do
      data = api.city_by_id(location.api_id)
      travel 61.minutes
      expect(Rails.cache.read("city_weather/#{location.api_id}")).to be_nil
    end
  end
end
