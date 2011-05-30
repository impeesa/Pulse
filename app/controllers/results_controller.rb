class ResultsController < ApplicationController
  before_filter :check_permission

  def table
    @results = Result.sections('Sales').items('EQUAL')
    @terms = @results.terms_hash.delete_if { |key, val| !['CMTD', 'CYTD'].include?(key) }
    @classes = @results.classes_hash
    @types = @results.types_hash
  end

  def rev_by_div
    charts_by_div = %w(domestic_current_month
                       domestic_current_quarter
                       domestic_current_year
                       international_current_month
                       international_current_quarter
                       international_current_year
                       wrrs_current_month
                       wrrs_current_quarter
                       wrrs_current_year)
    @charts = Chart.all(:conditions => ["name in (?)", charts_by_div]).delete_if { |c| !current_user.charts.map(&:name).include? c.name }
  end

  def rev_by_prod
    total_products = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq.count
    @total_charts = total_products * 3
    @charts = [Chart.find_by_name('product')].delete_if { |c| !current_user.charts.map(&:name).include? c.name }
    @items = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq
  end

  def balance_sheet
    @charts = [Chart.find_by_name('line_of_credit')]
  end

  def check_permission
    #render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Results')
    render_layout_only unless current_user.can_see_this_tab?('Results')
  end
end
