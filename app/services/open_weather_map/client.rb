module OpenWeatherMap
  class Client
    include HTTParty
    include HttpStatuses

    base_uri 'https://api.openweathermap.org'

    OpenWeatherMapAPIError = Class.new(StandardError)



    def initialize(api_key = nil)
      # Specify default params, like unit formats (Fahrenheit, Celsius, Kelvin) or language
      @options = { query: { APPID: api_key } }
    end

    def request(method, endpoint, params)
      response = self.class.public_send(method, endpoint, parse_options(params))
      return response.parsed_response if response.code == HTTP_SUCCESS_CODE
    end

    private

    def parse_options(options)
      @options[:query].merge!(options)
      @options
    end
  end
end
