class Authentication < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id, :uid, :provider

  def self.create_from_omni_auth(omni_auth)
    create! :provider => omni_auth['provider'], :uid => omni_auth['uid']
  end

end
