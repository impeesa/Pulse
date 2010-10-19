class SessionsController < ApplicationController

  def create
    omni_auth = request.env['omniauth.auth']
    handle_omni_auth(omni_auth)
  end

  def destroy
    reset_session
    redirect_to root_path
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
      email = omni_auth['user_info']['email']
      user = User.find_by_email(email)
      raise User::NotFound.new(email) unless user
      raise User::Locked unless user.allowed_to_login
      user.authentications.create_from_omni_auth(omni_auth)
    end
    login user
    redirect_to root_path
  rescue User::NotFound => ex
    render :text => 'You must register with an administrator before loggin in.'
  rescue User::Locked
    render :text => 'Your account is locked.'
  end

end
