class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :weekid
      t.string :contactname
      t.float  :score
      t.text   :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
