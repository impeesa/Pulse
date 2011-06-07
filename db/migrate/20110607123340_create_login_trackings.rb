class CreateLoginTrackings < ActiveRecord::Migration
  def self.up
    create_table :login_trackings do |t|
      t.string   :email
      t.datetime :sign_in_at
    end
  end

  def self.down
    drop_table :login_trackings
  end
end
