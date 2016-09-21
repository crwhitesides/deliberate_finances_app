class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in user
      @user = user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def twitter_login
    render text: request.env['omniauth.auth'].to_yaml
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
