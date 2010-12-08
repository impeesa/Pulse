class User < ActiveRecord::Base

  has_many :authentications, :dependent => :destroy
  has_many :user_groups
  has_many :groups, :through => :user_groups

  validates_presence_of :email
  validates_inclusion_of :allowed_to_login, :in => [true, false]

  def self.find_authorized_by_id_or_email!(id_or_email)
    if id_or_email.is_a?(Integer) || id_or_email.match(/^[0-9]+$/)
      user = find_by_id(id_or_email)
    else
      user = find_by_email(id_or_email)
    end
    raise NotFound.new(id_or_email) unless user
    raise Locked unless user.allowed_to_login
    user
  end

  class NotFound < StandardError
    attr_reader :identifier
    def initialize(identifier)
      super "User '#{identifier}' not found. Create before they authenticate"
    end
  end

  class Locked < StandardError; end

end
