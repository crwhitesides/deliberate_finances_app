class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :provider, :uid, :password, :password_confirmation)
  end
end
