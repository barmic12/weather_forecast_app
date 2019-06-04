# frozen_string_literal: true

module OpenWeatherMap
  class CurrentWeather < Client
    ENDPOINT = '/data/2.5/weather'
    EXPIRATION = 1.hour
    def city_by_id(id)
      @response = Rails.cache.fetch("city_weather/#{id}", expires_in: EXPIRATION) do
        request(
          :get,
          ENDPOINT,
          id: id
        )
      end
      if @response['cod'] == HTTP_SUCCESS_CODE
        build_weather_object(@response)
      else
        build_error_message(@response['cod'], @response['message'])
      end
    end

    private

    def build_weather_object(output)
      OpenStruct.new(
        status:  true,
        code:    output['cod'],
        main:    OpenStruct.new(output['main']),
        weather: OpenStruct.new(output['weather'][0]),
        coord:   OpenStruct.new(output['coord']),
        wind:    OpenStruct.new(output['wind']),
        clouds:  OpenStruct.new(output['clouds']),
        rain:    OpenStruct.new(output['rain']),
        dt:      output['dt'],
        sys:     OpenStruct.new(output['sys']),
        id:      output['id']
    )
    end
  end
end
