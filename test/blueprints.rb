require 'machinist/active_record'

User.blueprint do
  email { 'example@example.com' }
  allowed_to_login { true }
end

Authentication.blueprint do
  user { User.make }
  provider { 'google_apps' }
  uid { 'secret' }
end
