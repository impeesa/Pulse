class AddTypeToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :Type, :string
  end

  def self.down
    remove_column :results, :Type
  end
end
