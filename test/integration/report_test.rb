require 'test_helper'

class ReportTest < ActionController::IntegrationTest

  test 'should display basic sales data in text' do
    import_sample_data
    visit results_path
    assert_contain 'Actual'
    assert_contain 'Target'
    assert_contain 'Prior Year'
    assert_contain '$5,207,103.54'
  end

end
