require 'machinist/active_record'
require 'faker'

User.blueprint do
  email { 'example@example.com' }
  allowed_to_login { true }
end

class User
  def self.make_admin
    user = make :email => 'jared@redningja.com'
    user.groups << Group.find_by_name!('Admin')
    user
  end
end

Authentication.blueprint do
  user { User.make }
  provider { 'google_apps' }
  uid { 'secret' }
end

Group.blueprint do
  name { Faker::Company.catch_phrase }
end
