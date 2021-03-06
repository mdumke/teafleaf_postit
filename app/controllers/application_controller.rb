class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user && current_user.admin
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_admin
    access_denied unless admin?
  end

  def access_denied(target = nil)
    flash['error'] = 'Permission denied!'
    redirect_to root_path
  end
end
