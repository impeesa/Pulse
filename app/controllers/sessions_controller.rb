class SessionsController < ApplicationController

  skip_before_filter :get_current_user

  def create
    omni_auth = request.env['omniauth.auth']
    handle_omni_auth(omni_auth)
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => 'Bye!'
  end

  def new
    user = User.authenticate(params[:email], params[:password])
    if user
      login user
      redirect_to root_path
    else
      redirect_to root_path
    end
    rescue User::NotFound => ex
      render_user_not_found
    rescue User::Locked
      render_user_locked
  end

  private

  # User must exist at this point to log in.
  # If Authentication already exists, get its user.
  # Else find the user according to the email and create a new authentication.
  def handle_omni_auth(omni_auth)
    authentication = Authentication.find_by_provider_and_uid(omni_auth['provider'], omni_auth['uid'])
    if authentication
      user = authentication.user
    else
      user = User.find_authorized_by_id_or_email!(omni_auth['user_info']['email'])
      user.authentications.create_from_omni_auth(omni_auth)
    end
    login user
    redirect_to root_path
  rescue User::NotFound => ex
    render_user_not_found
  rescue User::Locked
    render_user_locked
  end

end
