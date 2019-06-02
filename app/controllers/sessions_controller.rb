class SessionsController < ApplicationController
  
  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = t('sessions.create')
      redirect_to root_path
    else
      flash[:danger] = t('sessions.validation_error')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = t('sessions.delete')
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
