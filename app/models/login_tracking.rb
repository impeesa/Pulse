class LoginTracking < ActiveRecord::Base
  belongs_to :user

  def self.add(user)
    create!(:email => user.email, :sign_in_at => Time.now)
  end
end
