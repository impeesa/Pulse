class LoginTracking < ActiveRecord::Base
  def self.add(user)
    create!(:email => user.email, :sign_in_at => Time.now)
  end
end
