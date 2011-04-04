class ChartJavascriptsController < ApplicationController
  def trend_line
    current = Score.find_latest_available_month
    start_date = current.prev_year
    @npss = []
    @times = []
    for i in (0..12)
      current_date = start_date.months_since(i)
      @times << "#{current_date.strftime('%b-%y')}"
      record = Score.find_month(current_date)
      record.nil? ? @npss << 0 : @npss << record.nps
    end
    render :template => 'chart_javascripts/trend_line.js.erb'
  end

  def equal_sales_current_month
    @classes = ['Domestic', 'International']
    results = Result.sections('Sales').items('EQUAL')
    cmtd_actual = results.terms('CMTD').types('Actual')
    domestic_cmtd_actual = cmtd_actual.classes('Domestic').sum(:Value)
    international_cmtd_actual = cmtd_actual.classes('International').sum(:Value)
    @actual = [domestic_cmtd_actual, international_cmtd_actual]
    cmtd_plan = results.terms('CMTD').types('Plan')
    domestic_cmtd_plan = cmtd_plan.classes('Domestic').sum(:Value)
    international_cmtd_plan = cmtd_plan.classes('International').sum(:Value)
    @plan = [domestic_cmtd_plan, international_cmtd_plan]
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_pycm_actual = pycm_actual.classes('Domestic').sum(:Value)
    international_pycm_actual = pycm_actual.classes('International').sum(:Value)
    @prior_year = [domestic_pycm_actual, international_pycm_actual]
    chart = Chart.find_by_name('equal_sales_current_month')
    render :template => 'chart_javascripts/equal_sales_chart.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def equal_sales_year_to_date
    @classes = ['Domestic', 'International']
    results = Result.sections('Sales').items('EQUAL')
    cytd_actual = results.terms('CYTD').types('Actual')
    domestic_cytd_actual = cytd_actual.classes('Domestic').sum(:Value)
    international_cytd_actual = cytd_actual.classes('International').sum(:Value)
    @actual = [domestic_cytd_actual, international_cytd_actual]
    cytd_plan = results.terms('CYTD').types('Plan')
    domestic_cytd_plan = cytd_plan.classes('Domestic').sum(:Value)
    international_cytd_plan = cytd_plan.classes('International').sum(:Value)
    @plan = [domestic_cytd_plan, international_cytd_plan]
    pycm_actual = results.terms('PYTD').types('Actual')
    domestic_pycm_actual = pycm_actual.classes('Domestic').sum(:Value)
    international_pycm_actual = pycm_actual.classes('International').sum(:Value)
    @prior_year = [domestic_pycm_actual, international_pycm_actual]
    chart = Chart.find_by_name('equal_sales_year_to_date')
    render :template => 'chart_javascripts/equal_sales_chart.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def line_of_credit
    balance_sheet_cash_line_of_credit_current_month = Result.sections('Balance Sheet').items('Cash').classes('LOC').terms('CM')
    @balance = balance_sheet_cash_line_of_credit_current_month.types('Actual').sum(:Value)
    @line_of_credit = balance_sheet_cash_line_of_credit_current_month.types('Plan').sum(:Value)
    @available = @line_of_credit - @balance
    chart = Chart.find_by_name('line_of_credit')
    @width, @height = chart.width, chart.height
  end
end
