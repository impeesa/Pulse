class GroupTab < ActiveRecord::Base
  belongs_to :group
  belongs_to :tab

  def self.save_permissions(permissions)
    permissions.each do |group_id, tabs|
      GroupTab.find(:all, :conditions => ["group_id = ?", group_id.to_i]).each { |gt| gt.destroy }
      tabs.each { |t| GroupTab.create(:group_id => group_id.to_i, :tab_id => t.to_i) }
    end
  end
end
