class LocationsController < ApplicationController
  before_action :authenticate_user
  def index
    @locations = Location
                 .where('name LIKE ?', "#{params[:query]}%")
                 .page(params[:page])
  end
end
