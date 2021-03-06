require 'test_helper'

class AuthenticationTest < ActionController::IntegrationTest

  test 'results page without logging in does not show report' do
    visit results_path
    assert_not_contain 'Sales Results'
    assert_contain 'You must Login'
  end

  test 'successful authentication callback finds existing authentication and user and logs in user' do
    user = Authentication.make.user
    get_successful_omni_auth_callback user
    follow_redirect!
    signed_in_as? user
  end

  test 'successful authentication callback for first time user creates authentication and logs in user' do
    user = User.make
    get_successful_omni_auth_callback user
    follow_redirect!
    assert_not_nil user.authentications.first
    signed_in_as? user
  end

  test 'logout' do
    login User.make
    click_link 'Logout'
    follow_redirect!
    assert_contain 'You must Login to see this page'
  end

  test 'successful authentication callback for non existent user displays message to register with admin' do
    get_successful_omni_auth_callback User.new
    assert_flash_notice 'not find'
  end

  test 'login user not allowed to login shows lock' do
    user = User.make(:allowed_to_login => 'false')
    get_successful_omni_auth_callback user
    assert_flash_notice 'locked'
  end

  test 'logged in user is locked, then should not be able to continue to use app' do
    user = User.make
    login user
    visit root_path
    user.update_attribute :allowed_to_login, false
    visit root_path
    assert_flash_notice 'locked'
  end

end
