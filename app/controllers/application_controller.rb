class ApplicationController < ActionController::Base
  before_filter :set_site_infor, :get_current_user

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
    if session[:user_id]
      @current_user = User.find_authorized_by_id_or_email!(session[:user_id])
    #@current_user = User.find_authorized_by_id_or_email!(1)
    else
      render_layout_only 'Please login.'
    end
  rescue User::Locked
    render_user_locked
  rescue User::NotFound
    render_user_not_found
  end

  def require_admin
    unless @current_user.is_admin?
      render_layout_only 'You must be an administrator to access this page'
    end
  end

  def render_user_locked
    render_layout_only 'Your account is locked.'
  end

  def render_user_not_found
    render_layout_only 'Could not find you. Register with an Administrator.'
  end

  def render_layout_only(msg = nil)
    flash[:notice] = msg
    render :nothing => true, :layout => true
  end

  def set_site_infor
    @site_name =  Admin.get_site_name
    @footer_text = Admin.get_footer_text
  end
end
