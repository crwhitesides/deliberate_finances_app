class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in user
      @user = user
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_back_or @user.current_plan
    else
      flash.now[:danger] = "Hmmmm, it seems your email and password don't match"
      render 'new'
    end
  end

  def google_login
    begin
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to user.current_plan
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
