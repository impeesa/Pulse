class Group < ActiveRecord::Base
  has_many :user_groups, :dependent => :destroy
  has_many :users, :through => :user_groups

  has_many :chart_groups, :dependent => :destroy
  has_many :charts, :through => :chart_groups

  has_many :group_tabs, :dependent => :destroy
  has_many :tabs, :through => :group_tabs
end
