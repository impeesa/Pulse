class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.belongs_to :user
      t.belongs_to :group
    end
  end

  def self.down
    drop_table :user_groups
  end
end
