class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :user_groups, :dependent => :destroy
  has_many :groups, :through => :user_groups

  validates_presence_of :email
  validates_inclusion_of :allowed_to_login, :in => [true, false]

  def self.find_authorized_by_id_or_email!(id_or_email)
    if id_or_email.is_a?(Integer) || (id_or_email && id_or_email.match(/^[0-9]+$/))
      user = find_by_id(id_or_email)
    else
      user = find_by_email(id_or_email)
    end
    raise NotFound.new(id_or_email) unless user
    raise Locked unless user.allowed_to_login
    user
  end

  def charts
    groups.map(&:charts).flatten
  end

  class NotFound < StandardError
    attr_reader :identifier
    def initialize(identifier)
      super "User '#{identifier}' not found. Create before they authenticate"
    end
  end

  class Locked < StandardError; end

  def can_see_this_tab?(tab_name)
    groups = self.groups
    can_see = false
    groups.each do |group|
      if group.tabs.map(&:name).include? tab_name  
        can_see = true
        break
      end
    end
    can_see
  end

  def self.make_local_admin
    User.create(:email => 'ndgiang84@xiga.info', :allowed_to_login => true, :is_admin => true)
    user = User.find_by_email(:first, 'ndgiang84@xiga.info')
    User.set_password(user.id, '123456')
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)

    if user
      expected_password = encrypted_password(password, user.salt)
      user = nil unless user.hashed_password == expected_password
    end

    user
  end

  def self.set_password(user_id, new_password)
    user = User.find_by_id(user_id)
    user.password = new_password
    user.hashed_password = encrypted_password(new_password, user.salt)
    user.save
  end

  def password
    @password
  end
            
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  private

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
              
  def self.encrypted_password(password,salt)
    string_to_hash = password + "pulse" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
