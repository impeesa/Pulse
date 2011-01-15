require 'test_helper'

class ResultsTest < ActionController::IntegrationTest

  include Webrat::HaveTagMatcher

  test 'should only display charts that belong to logged in user\'s groups' do
    group = Group.make
    user = User.make
    user.groups << group
    charts = Chart.names.map do |name|
      Chart.make :name => name
    end
    chart = charts.pop
    chart.groups << group
    login user
    visit results_path
    assert_chart_js_included chart
    charts.each do |chart_not_shown|
      assert_no_chart_js_included chart_not_shown
    end
  end

  def assert_chart_js_included(chart)
    assert_have_tag script_source(chart)
  end

  def assert_no_chart_js_included(chart)
    assert_have_no_tag script_source(chart)
  end

  def script_source(chart)
    "script[@src='#{chart_javascripts_path(chart.name)[1..-1] + '.js'}']"
  end

end
