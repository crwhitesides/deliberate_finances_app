class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.provider, @user.uid = "not_applicable", "not_applicable" # Tweak to make up for the lack of :provider and :uid attributes that can't have a null value
    if @user.save
      @user.create_initial_set_of_plans
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
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

  def require_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :provider, :uid, :password, :password_confirmation)
  end
end
