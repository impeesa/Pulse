class Tab < ActiveRecord::Base
  has_many :group_tabs, :dependent => :destroy
  has_many :groups, :through => :group_tabs
end
