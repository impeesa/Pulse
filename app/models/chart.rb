# This model only really represents the chart's name.
# This model was created to accommodate groups.

class Chart < ActiveRecord::Base

  has_many :chart_groups, :dependent => :destroy
  has_many :groups, :through => :chart_groups

  def self.names
    @names ||= ['equal_sales_year_to_date', 'equal_sales_current_month', 'line_of_credit', 'trend_line'].freeze
  end

  validates_presence_of :name
  validates_inclusion_of :name, :in => names

  DEFAULT_WIDTH = {
    self.names[0] => 473,
    self.names[1] => 473,
    self.names[2] => 350
  }

  DEFAULT_HEIGHT = {
    self.names[0] => 318,
    self.names[1] => 318,
    self.names[2] => 350
  }

  def self.reset_all_size
    Chart.all.each_with_index do |c, i|
      c.update_attributes(:width => Chart::DEFAULT_WIDTH[Chart::names[i]], :height => Chart::DEFAULT_HEIGHT[Chart::names[i]])
    end
  end
end
