# frozen_string_literal: true

module OpenWeatherMap
  class CurrentWeather < Client
    ENDPOINT = '/data/2.5/weather'
    def city_by_id(id)
      response = request(
                 :get,
                 ENDPOINT,
                 id: id
      )
      build_weather_object(response) if response['cod'] == HTTP_SUCCESS_CODE
    end

    private

    def build_weather_object(output)
      OpenStruct.new(
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
