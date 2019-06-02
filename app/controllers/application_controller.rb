# frozen_string_literal: true

class ApplicationController < ActionController::Base

  def authenticate_user
    redirect_to root_path unless current_user
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
