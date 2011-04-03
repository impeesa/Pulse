class CreateNps < ActiveRecord::Migration
  def self.up
    create_table :nps do |t|
      t.integer  :nps_id
      t.string   :week_id
      t.string   :accountname
      t.string   :contactname
      t.float    :score
      t.text     :comments
      t.datetime :submitdate

      t.timestamps
    end
  end

  def self.down
    drop_table :nps
  end
end
