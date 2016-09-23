class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in, only: [:show]

  def show
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.provider, @user.uid = "not_applicable", "not_applicable" # Tweak to make up for the lack of :provider and :uid attributes that can't have a null value
    if @user.save
      log_in @user
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :provider, :uid, :password, :password_confirmation)
  end
end
