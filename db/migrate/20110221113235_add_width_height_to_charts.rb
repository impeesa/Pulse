class AddWidthHeightToCharts < ActiveRecord::Migration
  def self.up
    add_column :charts, :width, :integer
    add_column :charts, :height, :integer

    Chart.all.each_with_index do |c, i|
      c.update_attributes(:width => Chart::DEFAULT_WIDTH[Chart::names[i]], :height => Chart::DEFAULT_HEIGHT[Chart::names[i]])
    end
  end

  def self.down
    remove_column :charts, :width
    remove_column :charts, :height
  end
end
