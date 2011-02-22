class CreateAdminsTable < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :site_name
      t.string :footer_text
    end
  end

  def self.down
    drop_table :admins
  end
end
