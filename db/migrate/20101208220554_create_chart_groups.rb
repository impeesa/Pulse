class CreateChartGroups < ActiveRecord::Migration
  def self.up
    create_table :chart_groups do |t|
      t.belongs_to :chart
      t.belongs_to :group
    end
  end

  def self.down
    drop_table :chart_groups
  end
end
