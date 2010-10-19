class ApplicationController < ActionController::Base

  before_filter :get_current_user
  
  protect_from_forgery
  helper_method :current_user, :signed_in?

  protected

  def current_user
    @current_user
  end

  def signed_in?
    !!current_user
  end

  def login(user)
    session[:user_id] = user.id
  end

  def get_current_user
    @current_user = User.find_authorized_by_id_or_email!(session[:user_id])
  rescue User::Locked
    render_user_locked
  rescue User::NotFound
    render_user_not_found
  end

  def render_user_locked
    render :text => 'Your account is locked.'
  end
  
  def render_user_not_found
    render :text => 'register with an Administrator.'
  end

end
