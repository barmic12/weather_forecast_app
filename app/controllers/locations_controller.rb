class LocationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_location, only: :follow
  before_action :set_follow, only: :unfollow
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
    if current_user.locations << @location
      flash[:success] = t('locations.follow.success')
    else
      flash[:danger] = t('locations.follow.failure')
    end
    redirect_to following_locations_path
  end

  def unfollow
    if @follow.destroy
      flash[:success] = t('locations.unfollow.success')
    else
      flash[:danger] = t('locations.unfollow.failure')
    end
    redirect_to following_locations_path
  end

  private

  def set_location
    @location = Location.find_by(id: params[:id])
    unless @location
      flash[:danger] = t('locations.location.not_found')
      redirect_to following_locations_path
    end
  end

  def set_follow
    @follow = Follow.find_by(user: current_user, location_id: params[:id])
    unless @follow
      flash[:danger] = t('locations.follow.not_found')
      redirect_to following_locations_path
    end
  end
end
