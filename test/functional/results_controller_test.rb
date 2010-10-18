require 'test_helper'

class ResultsControllerTest < ActionController::TestCase

  test 'should display basic sales data in text - no pictures actual vs. plan vs. prior year' do
    visit(results_path)
    response.should contain('Actual')
    response.should contain('Plan')
    response.should contain('Prior Year')
  end

end
