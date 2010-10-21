class ChartsController < ApplicationController

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
    render :template => 'charts/equal_sales_chart.js.erb'
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
    render :template => 'charts/equal_sales_chart.js.erb'
  end

  def line_of_credit
    balance_sheet_cash_line_of_credit_current_month = Result.sections('Balance Sheet').items('Cash').classes('LOC').terms('CM')
    @balance = balance_sheet_cash_line_of_credit_current_month.types('Actual').sum(:Value)
    @line_of_credit = balance_sheet_cash_line_of_credit_current_month.types('Plan').sum(:Value)
    @available = @line_of_credit - @balance
  end

end
