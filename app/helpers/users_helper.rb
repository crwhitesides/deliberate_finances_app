module UsersHelper
  def logged_in?
    current_user.id != nil
  end
end
