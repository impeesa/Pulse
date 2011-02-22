class AddHashedPasswordAndSaltToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :hashed_password, :string, :default => nil
    add_column :users, :salt, :string

    User.find_each(:batch_size => 100) { |user| user.hashed_password = nil }
  end

  def self.down
    remove_column :users, :hashed_password
    remove_column :users, :salt
  end
end
