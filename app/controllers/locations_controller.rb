class LocationsController < ApplicationController
  before_action :authenticate_user
  def index
    @locations = Location
                 .where('name LIKE ?', "#{params[:query]}%")
                 .page(params[:page])
  end

  def following
    @locations = current_user.locations
    api = OpenWeatherMap::CurrentWeather.new(ENVied.OPEN_WEATHER_API_KEY)
    @locations.each do |location|
      location.weather = api.city_by_id(location.api_id)
    end
  end

  def follow
    @location = Location.find_by(id: params[:id])
    if @location
      if current_user.locations << @location
        flash[:success] = t('locations.follow.success')
      else
        flash[:danger] = t('locations.follow.validation_error')
      end
    else
      flash[:danger] = t('locations.follow.not_exists')
    end
    redirect_to following_locations_path
  end
end
