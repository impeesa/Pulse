ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webrat'
Webrat.configure do |config|
  config.mode = :rack
end
require 'blueprints'

require 'import_sample_data'

class ActiveSupport::TestCase

  def omni_auth_header(options = {})
    default = {'provider' => 'google_apps', 'uid' => 'secret', 'user_info' => {'email' => 'example@example.com'}}
    default.deep_merge(options)
  end

  def signed_in_as?(user)
    assert_contain "Logged in as #{user.email}"
  end

  def get_successful_omni_auth_callback
    header('omniauth.auth', omni_auth_header)
    visit successful_authentication_path(:provider => 'google_apps')
  end

  def login(user = nil)
    user = user || User.make
    get_successful_omni_auth_callback
    follow_redirect!
    signed_in_as? user
  end

end
