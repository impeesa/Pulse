class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.string  :week_id
      t.float   :nps
      t.integer :score
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
