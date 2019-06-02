class AccountSettingsController < ApplicationController
  before_action :authenticate_user

  def index; end

  def destroy
    current_user.destroy
    reset_session
    flash[:success] = t('account_settings.index.remove_message')
    redirect_to root_path
  end
end
