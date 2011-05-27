class ResultsController < ApplicationController
  before_filter :check_permission

  def table
    @results = Result.sections('Sales').items('EQUAL')
    @terms = @results.terms_hash.delete_if { |key, val| !['CMTD', 'CYTD'].include?(key) }
    @classes = @results.classes_hash
    @types = @results.types_hash
  end

  def rev_by_div
    total_divs = 3 # [Domestic International WRRS]
    @total_charts = total_divs * 3
    @charts = [Chart.find_by_name('division')].delete_if { |c| !current_user.charts.map(&:name).include? c.name }
  end

  def rev_by_prod
    total_products = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq.count
    @total_charts = total_products * 3
    @charts = [Chart.find_by_name('product')].delete_if { |c| !current_user.charts.map(&:name).include? c.name }
  end

  def balance_sheet
    @charts = [Chart.find_by_name('line_of_credit')]
  end

  def check_permission
    #render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Results')
    render_layout_only unless current_user.can_see_this_tab?('Results')
  end
end
