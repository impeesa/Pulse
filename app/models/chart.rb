# This model only really represents the chart's name.
# This model was created to accommodate groups.

class Chart < ActiveRecord::Base

  has_many :chart_groups, :dependent => :destroy
  has_many :groups, :through => :chart_groups

  def self.names
    chart_names = %w(line_of_credit
                     trend_line
                     domestic_current_month
                     domestic_current_quarter
                     domestic_current_year
                     international_current_month
                     international_current_quarter
                     international_current_year
                     wrrs_current_month
                     wrrs_current_quarter
                     wrrs_current_year
                     product
                     single_product)
    @names ||= chart_names.freeze
  end

  validates_presence_of :name
  validates_inclusion_of :name, :in => names

  DEFAULT_WIDTH = {
    self.names[0] => 370,
    self.names[2] => 500,
    self.names[3] => 500,
    self.names[4] => 500,
    self.names[5] => 500,
    self.names[6] => 500,
    self.names[7] => 500,
    self.names[8] => 500,
    self.names[9] => 500,
    self.names[10] => 500,
    self.names[11] => 400,
    self.names[12] => 430
  }

  DEFAULT_HEIGHT = {
    self.names[0] => 350,
    self.names[2] => 211,
    self.names[3] => 211,
    self.names[4] => 211,
    self.names[5] => 211,
    self.names[6] => 211,
    self.names[7] => 211,
    self.names[8] => 211,
    self.names[9] => 211,
    self.names[10] => 211,
    self.names[11] => 211,
    self.names[12] => 211
  }

  def self.reset_all_size
    Chart.all.each_with_index do |c, i|
      c.update_attributes(:width => Chart::DEFAULT_WIDTH[Chart::names[i]], :height => Chart::DEFAULT_HEIGHT[Chart::names[i]])
    end
  end
end
