class GroupTab < ActiveRecord::Migration
  def self.up
    create_table :group_tabs do |t|
      t.integer :group_id
      t.integer :tab_id
    end
  end

  def self.down
    drop_table :group_tabs
  end
end
