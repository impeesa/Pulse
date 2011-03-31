class AddAccountnameToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :accountname, :string
  end

  def self.down
    remove_column :comments, :accountname
  end
end
