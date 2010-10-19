require 'test_helper'

class AuthenticationTest < ActionController::IntegrationTest

  test 'successful authentication callback creates new user' do
    header('omniauth.auth', {:stuff => :yay})
    visit successful_authentication_path(:provider => 'google_apps')
    flunk
  end

end
