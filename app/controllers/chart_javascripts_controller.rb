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
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('Domestic')

    # actual, plan, prior
    cmtd_actual = results.terms('CMTD').types('Actual')
    cmtd_plan   = results.terms('CMTD').types('Plan')
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_cmtd_actuals = []
    domestic_cmtd_plans   = []
    domestic_pycm_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cmtd_actual.items(item).sum(:Value).floor == 0 and cmtd_plan.items(item).sum(:Value).floor == 0 and pycm_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cmtd_actuals << cmtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cmtd_plans   << cmtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pycm_actuals << pycm_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cmtd_actuals << domestic_cmtd_actuals.sum
    domestic_cmtd_plans   << domestic_cmtd_plans.sum
    domestic_pycm_actuals << domestic_pycm_actuals.sum
    @actual     = domestic_cmtd_actuals
    @plan       = domestic_cmtd_plans
    @prior_year = domestic_pycm_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('domestic_current_month')
    render :template => 'chart_javascripts/new_charts/domestic_current_month.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def domestic_current_quarter
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('Domestic')

    # actual, plan, prior
    cqtd_actual = results.terms('CYQT').types('Actual')
    cqtd_plan = results.terms('CYQT').types('Plan')
    pyqt_actual = results.terms('PYQT').types('Actual')
    domestic_cqtd_actuals = []
    domestic_cqtd_plans   = []
    domestic_pyqt_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cqtd_actual.items(item).sum(:Value).floor == 0 and cqtd_plan.items(item).sum(:Value).floor == 0 and pyqt_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cqtd_actuals << cqtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cqtd_plans   << cqtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pyqt_actuals << pyqt_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cqtd_actuals << domestic_cqtd_actuals.sum
    domestic_cqtd_plans << domestic_cqtd_plans.sum
    domestic_pyqt_actuals << domestic_pyqt_actuals.sum
    @actual = domestic_cqtd_actuals
    @plan = domestic_cqtd_plans
    @prior_year = domestic_pyqt_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('domestic_current_quarter')
    render :template => 'chart_javascripts/new_charts/domestic_current_quarter.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def domestic_current_year
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('Domestic')

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    cytd_plan   = results.terms('CYTD').types('Plan')
    pytd_actual = results.terms('PYTD').types('Actual')
    domestic_cytd_actuals = []
    domestic_cytd_plans   = []
    domestic_pytd_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cytd_actual.items(item).sum(:Value).floor == 0 and cytd_plan.items(item).sum(:Value).floor == 0 and pytd_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cytd_actuals << cytd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cytd_plans << cytd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pytd_actuals << pytd_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cytd_actuals << domestic_cytd_actuals.sum
    domestic_cytd_plans << domestic_cytd_plans.sum
    domestic_pytd_actuals << domestic_pytd_actuals.sum
    @actual = domestic_cytd_actuals
    @plan = domestic_cytd_plans
    @prior_year = domestic_pytd_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('domestic_current_year')
    render :template => 'chart_javascripts/new_charts/domestic_current_year.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  #
  # charts for International
  #

  def international_current_month
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('International')

    # actual
    cmtd_actual = results.terms('CMTD').types('Actual')
    cmtd_plan   = results.terms('CMTD').types('Plan')
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_cmtd_actuals = []
    domestic_cmtd_plans   = []
    domestic_pycm_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cmtd_actual.items(item).sum(:Value).floor == 0 and cmtd_plan.items(item).sum(:Value).floor == 0 and pycm_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cmtd_actuals << cmtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cmtd_plans << cmtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pycm_actuals << pycm_actual.items(item).sum(:Value).floor unless item == ["Total"]
      end
    end

    domestic_cmtd_actuals << domestic_cmtd_actuals.sum
    domestic_cmtd_plans << domestic_cmtd_plans.sum
    domestic_pycm_actuals << domestic_pycm_actuals.sum
    @actual = domestic_cmtd_actuals
    @plan = domestic_cmtd_plans
    @prior_year = domestic_pycm_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('international_current_month')
    render :template => 'chart_javascripts/new_charts/international_current_month.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def international_current_quarter
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('International')

    # actual
    cqtd_actual = results.terms('CYQT').types('Actual')
    cqtd_plan   = results.terms('CYQT').types('Plan')
    pyqt_actual = results.terms('PYQT').types('Actual')
    domestic_cqtd_actuals = []
    domestic_cqtd_plans   = []
    domestic_pyqt_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cqtd_actual.items(item).sum(:Value).floor == 0 and cqtd_plan.items(item).sum(:Value).floor == 0 and pyqt_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cqtd_actuals << cqtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cqtd_plans << cqtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pyqt_actuals << pyqt_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cqtd_actuals << domestic_cqtd_actuals.sum
    domestic_cqtd_plans << domestic_cqtd_plans.sum
    domestic_pyqt_actuals << domestic_pyqt_actuals.sum
    @actual = domestic_cqtd_actuals
    @plan = domestic_cqtd_plans
    @prior_year = domestic_pyqt_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('international_current_quarter')
    render :template => 'chart_javascripts/new_charts/international_current_quarter.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def international_current_year
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('International')

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    cytd_plan = results.terms('CYTD').types('Plan')
    pytd_actual = results.terms('PYTD').types('Actual')
    domestic_cytd_actuals = []
    domestic_cytd_plans   = []
    domestic_pytd_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cytd_actual.items(item).sum(:Value).floor == 0 and cytd_plan.items(item).sum(:Value).floor == 0 and pytd_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cytd_actuals << cytd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cytd_plans << cytd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pytd_actuals << pytd_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cytd_actuals << domestic_cytd_actuals.sum
    domestic_cytd_plans << domestic_cytd_plans.sum
    domestic_pytd_actuals << domestic_pytd_actuals.sum
    @actual = domestic_cytd_actuals
    @plan = domestic_cytd_plans
    @prior_year = domestic_pytd_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('international_current_year')
    render :template => 'chart_javascripts/new_charts/international_current_year.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  #
  # Charts for WRRS
  #

  def wrrs_current_month
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('WRRS')

    # actual
    cmtd_actual = results.terms('CMTD').types('Actual')
    cmtd_plan   = results.terms('CMTD').types('Plan')
    pycm_actual = results.terms('PYCM').types('Actual')
    domestic_cmtd_actuals = []
    domestic_cmtd_plans   = []
    domestic_pycm_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cmtd_actual.items(item).sum(:Value).floor == 0 and cmtd_plan.items(item).sum(:Value).floor == 0 and pycm_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cmtd_actuals << cmtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cmtd_plans << cmtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pycm_actuals << pycm_actual.items(item).sum(:Value).floor unless item == ["Total"]
      end
    end

    domestic_cmtd_actuals << domestic_cmtd_actuals.sum
    domestic_cmtd_plans << domestic_cmtd_plans.sum
    domestic_pycm_actuals << domestic_pycm_actuals.sum
    @actual = domestic_cmtd_actuals
    @plan = domestic_cmtd_plans
    @prior_year = domestic_pycm_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('wrrs_current_month')
    render :template => 'chart_javascripts/new_charts/wrrs_current_month.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def wrrs_current_quarter
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('WRRS')

    # actual
    cqtd_actual = results.terms('CYQT').types('Actual')
    cqtd_plan   = results.terms('CYQT').types('Plan')
    pyqt_actual = results.terms('PYQT').types('Actual')
    domestic_cqtd_actuals = []
    domestic_cqtd_plans = []
    domestic_pyqt_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cqtd_actual.items(item).sum(:Value).floor == 0 and cqtd_plan.items(item).sum(:Value).floor == 0 and pyqt_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cqtd_actuals << cqtd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cqtd_plans << cqtd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pyqt_actuals << pyqt_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cqtd_actuals << domestic_cqtd_actuals.sum
    domestic_cqtd_plans << domestic_cqtd_plans.sum
    domestic_pyqt_actuals << domestic_pyqt_actuals.sum
    @actual = domestic_cqtd_actuals
    @plan = domestic_cqtd_plans
    @prior_year = domestic_pyqt_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('wrrs_current_quarter')
    render :template => 'chart_javascripts/new_charts/wrrs_current_quarter.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def wrrs_current_year
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq << "Total"
    results = Result.sections('Sales').classes('WRRS')

    # actual
    cytd_actual = results.terms('CYTD').types('Actual')
    cytd_plan   = results.terms('CYTD').types('Plan')
    pytd_actual = results.terms('PYTD').types('Actual')
    domestic_cytd_actuals = []
    domestic_cytd_plans   = []
    domestic_pytd_actuals = []
    items_to_be_removed   = []

    for item in @items
      if (cytd_actual.items(item).sum(:Value).floor == 0 and cytd_plan.items(item).sum(:Value).floor == 0 and pytd_actual.items(item).sum(:Value).floor == 0 and item != "Total")
        items_to_be_removed << item
      else
        domestic_cytd_actuals << cytd_actual.items(item).sum(:Value).floor unless item == "Total"
        domestic_cytd_plans << cytd_plan.items(item).sum(:Value).floor unless item == "Total"
        domestic_pytd_actuals << pytd_actual.items(item).sum(:Value).floor unless item == "Total"
      end
    end

    domestic_cytd_actuals << domestic_cytd_actuals.sum
    domestic_cytd_plans << domestic_cytd_plans.sum
    domestic_pytd_actuals << domestic_pytd_actuals.sum
    @actual = domestic_cytd_actuals
    @plan = domestic_cytd_plans
    @prior_year = domestic_pytd_actuals
    @items.delete_if { |item| items_to_be_removed.include? item }

    chart = Chart.find_by_name('wrrs_current_year')
    render :template => 'chart_javascripts/new_charts/wrrs_current_year.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  #
  # charts by Product
  #
  def product
    @classes = ['Domestic', 'Inter', 'WRRS', 'Total']
    @items = Result.sections('Sales').select('item').map { |i| i.attributes.values }.flatten.compact.uniq

    @actuals = []
    @plans = []
    @prior_years = []
    @chart_names = []

    for item in @items
      # current month version
      @chart_names << "#{item} - Current Month"
      results = Result.sections('Sales').items(item)
      cmtd_actual = results.terms('CMTD').types('Actual')
      cmtd_plan = results.terms('CMTD').types('Plan')
      pycm_actual = results.terms('PYCM').types('Actual')
      cmtd_actuals = []
      cmtd_plans = []
      pycm_actuals = []

      @classes.each do |klass| 
        cmtd_actuals << cmtd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cmtd_plans << cmtd_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pycm_actuals << pycm_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cmtd_actuals << cmtd_actuals.sum
      cmtd_plans << cmtd_plans.sum
      pycm_actuals << pycm_actuals.sum
      @actuals << cmtd_actuals
      @plans << cmtd_plans
      @prior_years << pycm_actuals

      # current quarter version
      @chart_names << "#{item} - Current Quarter"
      results = Result.sections('Sales').items(item)
      cyqt_actual = results.terms('CYQT').types('Actual')
      cyqt_plan = results.terms('CYQT').types('Plan')
      pyqt_actual = results.terms('PYQT').types('Actual')
      cyqt_actuals = []
      cyqt_plans = []
      pyqt_actuals = []

      @classes.each do |klass| 
        cyqt_actuals << cyqt_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cyqt_plans << cyqt_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pyqt_actuals << pyqt_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cyqt_actuals << cyqt_actuals.sum
      cyqt_plans << cyqt_plans.sum
      pyqt_actuals << pyqt_actuals.sum
      @actuals << cyqt_actuals
      @plans << cyqt_plans
      @prior_years << pyqt_actuals

      # current year version
      @chart_names << "#{item} - Current Year"
      results = Result.sections('Sales').items(item)
      cytd_actual = results.terms('CYTD').types('Actual')
      cytd_plan = results.terms('CYTD').types('Plan')
      pytd_actual = results.terms('PYTD').types('Actual')
      cytd_actuals = []
      cytd_plans = []
      pytd_actuals = []

      @classes.each do |klass| 
        cytd_actuals << cytd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cytd_plans << cytd_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pytd_actuals << pytd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cytd_actuals << cytd_actuals.sum
      cytd_plans << cytd_plans.sum
      pytd_actuals << pytd_actuals.sum
      @actuals << cytd_actuals
      @plans << cytd_plans
      @prior_years << pytd_actuals
    end
    
    chart = Chart.find_by_name('product')
    render :template => 'chart_javascripts/new_charts/products.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end

  def single_product
    product = params[:product].strip
    @classes = ['Domestic', 'Inter', 'WRRS', 'Total']
    @items = [Result.find(:first, :conditions => ["section = ? and item = ?", 'Sales', product]).Item]

    @actuals = []
    @plans = []
    @prior_years = []
    @chart_names = []

    for item in @items
      # current month version
      @chart_names << "#{item} - Current Month"
      results = Result.sections('Sales').items(item)
      cmtd_actual = results.terms('CMTD').types('Actual')
      cmtd_plan = results.terms('CMTD').types('Plan')
      pycm_actual = results.terms('PYCM').types('Actual')
      cmtd_actuals = []
      cmtd_plans = []
      pycm_actuals = []

      @classes.each do |klass| 
        cmtd_actuals << cmtd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cmtd_plans << cmtd_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pycm_actuals << pycm_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cmtd_actuals << cmtd_actuals.sum
      cmtd_plans << cmtd_plans.sum
      pycm_actuals << pycm_actuals.sum
      @actuals << cmtd_actuals
      @plans << cmtd_plans
      @prior_years << pycm_actuals

      # current quarter version
      @chart_names << "#{item} - Current Quarter"
      results = Result.sections('Sales').items(item)
      cyqt_actual = results.terms('CYQT').types('Actual')
      cyqt_plan = results.terms('CYQT').types('Plan')
      pyqt_actual = results.terms('PYQT').types('Actual')
      cyqt_actuals = []
      cyqt_plans = []
      pyqt_actuals = []

      @classes.each do |klass| 
        cyqt_actuals << cyqt_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cyqt_plans << cyqt_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pyqt_actuals << pyqt_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cyqt_actuals << cyqt_actuals.sum
      cyqt_plans << cyqt_plans.sum
      pyqt_actuals << pyqt_actuals.sum
      @actuals << cyqt_actuals
      @plans << cyqt_plans
      @prior_years << pyqt_actuals

      # current year version
      @chart_names << "#{item} - Current Year"
      results = Result.sections('Sales').items(item)
      cytd_actual = results.terms('CYTD').types('Actual')
      cytd_plan = results.terms('CYTD').types('Plan')
      pytd_actual = results.terms('PYTD').types('Actual')
      cytd_actuals = []
      cytd_plans = []
      pytd_actuals = []

      @classes.each do |klass| 
        cytd_actuals << cytd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
        cytd_plans << cytd_plan.classes(klass).sum(:Value).floor if klass != 'Total'
        pytd_actuals << pytd_actual.classes(klass).sum(:Value).floor if klass != 'Total'
      end

      cytd_actuals << cytd_actuals.sum
      cytd_plans << cytd_plans.sum
      pytd_actuals << pytd_actuals.sum
      @actuals << cytd_actuals
      @plans << cytd_plans
      @prior_years << pytd_actuals
    end
    
    chart = Chart.find_by_name('single_product')
    render :template => 'chart_javascripts/new_charts/single_products.js.erb', :locals => { :width => chart.width, :height => chart.height }
  end
end
