class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :D_ID
      t.string :Section
      t.string :Item
      t.string :Class
      t.string :Term
      t.date :Period
      t.float :Value

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
