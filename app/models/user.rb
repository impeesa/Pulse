class User < ActiveRecord::Base

  has_many :authentications, :dependent => :destroy

  validates_presence_of :email
  validates_inclusion_of :allowed_to_login, :in => [true, false]

  class NotFound < StandardError
    attr_reader :identifier
    def initialize(identifier)
      super "User '#{identifier}' not found. Create before they authenticate"
    end
  end

  class Locked < StandardError; end

end
