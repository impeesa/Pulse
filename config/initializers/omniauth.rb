require 'omniauth'
require 'openid/store/filesystem'
unless Rails.env == 'test'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_apps, nil, :domain => 'https://www.google.com/accounts/o8/id'
  end
  # use OmniAuth::Strategies::LDAP, :host => '192.168.1.100', :port => 389, :method => :plain, :base => 'DC=IMI', :uid => 'samaccountname', :try_sasl => true, :sasl_mechanisms => "GSS-SPNEGO"
end
