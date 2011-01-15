# This model only really represents the chart's name.
# This model was created to accommodate groups.

class Chart < ActiveRecord::Base

  has_many :chart_groups, :dependent => :destroy
  has_many :groups, :through => :chart_groups

  def self.names
    @names ||= ['equal_sales_year_to_date', 'equal_sales_current_month', 'line_of_credit'].freeze
  end

  validates_presence_of :name
  validates_inclusion_of :name, :in => names

end
