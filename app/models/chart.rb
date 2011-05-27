# This model only really represents the chart's name.
# This model was created to accommodate groups.

class Chart < ActiveRecord::Base

  has_many :chart_groups, :dependent => :destroy
  has_many :groups, :through => :chart_groups

  def self.names
    chart_names = %w(line_of_credit
                     trend_line
                     division
                     product)
    @names ||= chart_names.freeze
  end

  validates_presence_of :name
  validates_inclusion_of :name, :in => names

  DEFAULT_WIDTH = {
    self.names[0] => 350,
    self.names[2] => 500,
    self.names[3] => 400
  }

  DEFAULT_HEIGHT = {
    self.names[0] => 350,
    self.names[2] => 211,
    self.names[3] => 211
  }

  def self.reset_all_size
    Chart.all.each_with_index do |c, i|
      c.update_attributes(:width => Chart::DEFAULT_WIDTH[Chart::names[i]], :height => Chart::DEFAULT_HEIGHT[Chart::names[i]])
    end
  end
end
