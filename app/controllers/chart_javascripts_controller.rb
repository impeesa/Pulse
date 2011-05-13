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

    # actual
    cmtd_actual = results.terms('CMTD').types('Actual')
    domestic_cmtd_actual = cmtd_actual.classes('Domestic').sum(:Value)
    international_cmtd_actual = cmtd_actual.classes('International').sum(:Value)
    @actual = [domestic_cmtd_actual, international_cmtd_actual]

    # plan
    cmtd_plan = results.terms('CMTD').types('Plan')
    domestic_cmtd_plan = cmtd_plan.classes('Domestic').sum(:Value)
    international_cmtd_plan = cmtd_plan.classes('International').sum(:Value)
    @plan = [domestic_cmtd_plan, international_cmtd_plan]

    # prior year
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

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    domestic_cytd_actual = cytd_actual.classes('Domestic').sum(:Value)
    international_cytd_actual = cytd_actual.classes('International').sum(:Value)
    @actual = [domestic_cytd_actual, international_cytd_actual]

    # plan
    cytd_plan = results.terms('CYTD').types('Plan')
    domestic_cytd_plan = cytd_plan.classes('Domestic').sum(:Value)
    international_cytd_plan = cytd_plan.classes('International').sum(:Value)
    @plan = [domestic_cytd_plan, international_cytd_plan]

    # prior year
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

  #
  # charts for Domestic
  #

  def domestic_current_month
    @items = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    puts @items.inspect

    results = Result.sections('Sales').classes('Domestic')

    # actual
    cmtd_actual = results.terms('CMTD').types('Actual')
    domestic_cmtd_actuals = []
    for item in @items
      domestic_cmtd_actuals << cmtd_actual.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cmtd_actuals << domestic_cmtd_actuals.sum
    @actual = domestic_cmtd_actuals

    # plan
    cmtd_plan = results.terms('CMTD').types('Plan')
    domestic_cmtd_plans = []
    for item in @items
      domestic_cmtd_plans << cmtd_plan.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cmtd_plans << domestic_cmtd_plans.sum
    @plan = domestic_cmtd_plans

    # prior year
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_pycm_actuals = []
    for item in @items
      domestic_pycm_actuals << pycm_actual.items(item).sum(:Value).floor unless item == ["Total"]
    end
    domestic_pycm_actuals << domestic_pycm_actuals.sum
    @prior_year = domestic_pycm_actuals

    chart = Chart.find_by_name('domestic_current_month')
    render :template => 'chart_javascripts/new_charts/domestic_current_month.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def domestic_current_quarter
    @items = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"

    results = Result.sections('Sales').classes('Domestic')

    # actual
    cqtd_actual = results.terms('CYQT').types('Actual')
    domestic_cqtd_actuals = []
    for item in @items
      domestic_cqtd_actuals << cqtd_actual.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cqtd_actuals << domestic_cqtd_actuals.sum
    @actual = domestic_cqtd_actuals

    # plan
    cqtd_plan = results.terms('CYQT').types('Plan')
    domestic_cqtd_plans = []
    for item in @items
      domestic_cqtd_plans << cqtd_plan.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cqtd_plans << domestic_cqtd_plans.sum
    @plan = domestic_cqtd_plans

    # prior year
    pyqt_actual = results.terms('PYQT').types('Actual')
    domestic_pyqt_actuals = []
    for item in @items
      domestic_pyqt_actuals << pyqt_actual.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_pyqt_actuals << domestic_pyqt_actuals.sum
    @prior_year = domestic_pyqt_actuals

    chart = Chart.find_by_name('domestic_current_quarter')
    render :template => 'chart_javascripts/new_charts/domestic_current_quarter.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def domestic_current_year
    @items = Result.select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"

    results = Result.sections('Sales').classes('Domestic')

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    domestic_cytd_actuals = []
    for item in @items
      domestic_cytd_actuals << cytd_actual.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cytd_actuals << domestic_cytd_actuals.sum
    @actual = domestic_cytd_actuals

    # plan
    cytd_plan = results.terms('CYTD').types('Plan')
    domestic_cytd_plans = []
    for item in @items
      domestic_cytd_plans << cytd_plan.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_cytd_plans << domestic_cytd_plans.sum
    @plan = domestic_cytd_plans

    # prior year
    pytd_actual = results.terms('PYTD').types('Actual')
    domestic_pytd_actuals = []
    for item in @items
      domestic_pytd_actuals << pytd_actual.items(item).sum(:Value).floor unless item == "Total"
    end
    domestic_pytd_actuals << domestic_pytd_actuals.sum
    @prior_year = domestic_pytd_actuals

    chart = Chart.find_by_name('domestic_current_year')
    render :template => 'chart_javascripts/new_charts/domestic_current_year.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  #
  # charts for International
  #

  def international_current_month
    @classes = ['International']

    results = Result.sections('Sales').items('EQUAL')

    # actual
    cmtd_actual = results.terms('CMTD').types('Actual')
    domestic_cmtd_actual = cmtd_actual.classes('Domestic').sum(:Value)
    @actual = [domestic_cmtd_actual]

    # plan
    cmtd_plan = results.terms('CMTD').types('Plan')
    domestic_cmtd_plan = cmtd_plan.classes('Domestic').sum(:Value)
    @plan = [domestic_cmtd_plan]

    # prior year
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_pycm_actual = pycm_actual.classes('Domestic').sum(:Value)
    @prior_year = [domestic_pycm_actual]

    chart = Chart.find_by_name('domestic_current_month')
    render :template => 'chart_javascripts/new_charts/international_current_month.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def international_current_quarter
    @classes = ['International']

    results = Result.sections('Sales').items('EQUAL')

    # actual
    cyqt_actual = results.terms('CYQT').types('Actual')
    domestic_cyqt_actual = cyqt_actual.classes('Domestic').sum(:Value)
    @actual = [domestic_cyqt_actual]

    # plan
    cyqt_plan = results.terms('CYQT').types('Plan')
    domestic_cyqt_plan = cyqt_plan.classes('Domestic').sum(:Value)
    @plan = [domestic_cyqt_plan]

    # prior year
    pycm_actual = results.terms('PYQT').types('Actual')
    domestic_pycm_actual = pycm_actual.classes('Domestic').sum(:Value)
    @prior_year = [domestic_pycm_actual]

    chart = Chart.find_by_name('domestic_current_quarter')
    render :template => 'chart_javascripts/new_charts/international_current_quarter.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def international_current_year
    @classes = ['International']

    results = Result.sections('Sales').items('EQUAL')

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    domestic_cytd_actual = cytd_actual.classes('Domestic').sum(:Value)
    @actual = [domestic_cytd_actual]

    # plan
    cytd_plan = results.terms('CYTD').types('Plan')
    domestic_cytd_plan = cytd_plan.classes('Domestic').sum(:Value)
    @plan = [domestic_cytd_plan]

    # prior year
    pytd_actual = results.terms('PYTD').types('Actual')
    domestic_pytd_actual = pytd_actual.classes('Domestic').sum(:Value)
    @prior_year = [domestic_pytd_actual]

    chart = Chart.find_by_name('domestic_current_year')
    render :template => 'chart_javascripts/new_charts/international_current_year.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end
end
