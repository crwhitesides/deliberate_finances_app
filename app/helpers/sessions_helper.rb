module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @user ||= user.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.id != nil
  end

  def require_logged_in?
    return redirect_to login_path unless logged_in?
  end
end
