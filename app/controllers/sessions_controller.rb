class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[new create close]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to path_after_login
    else
      flash.now[:alert] = 'Something wrong'
      render :new
    end
  end

  def close
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def path_after_login
    session[:return_to] || root_path
  end

end
