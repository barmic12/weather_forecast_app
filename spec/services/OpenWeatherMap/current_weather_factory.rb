# frozen_string_literal: true

module CurrentWeatherFactory
  def self.by_city_id(id)
  stubbed_json = {
    "coord": {
    "lon": 22.81,
    "lat": 44.47
    },
    "weather": [
    {
    "id": 500,
    "main": "Rain",
    "description": "light rain",
    "icon": "10d"
    }
    ],
    "base": "stations",
    "main": {
    "temp": 291.08,
    "pressure": 1011.52,
    "humidity": 88,
    "temp_min": 291.08,
    "temp_max": 291.08,
    "sea_level": 1011.52,
    "grnd_level": 993.62
    },
    "wind": {
    "speed": 1.47,
    "deg": 29.948
    },
    "rain": {
    "3h": 0.75
    },
    "clouds": {
    "all": 68
    },
    "dt": 1559584035,
    "sys": {
    "message": 0.0052,
    "country": "RO",
    "sunrise": 1559530000,
    "sunset": 1559585241
    },
    "timezone": 10800,
    "id": "#{id}",
    "name": "Rogova",
    "cod": 200
  }.to_json
  end
end
