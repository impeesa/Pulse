require 'test_helper'

class ReportTest < ActionController::IntegrationTest

  test 'should display basic sales data in text' do
    login
    import_sample_results
    visit results_table_path
    assert_contain 'Actual'
    assert_contain 'Plan'
    assert_contain 'Prior Year'
    assert_contain '$5,207,103.54'
  end

  test "should allow user to view only reports that belong to user's groups" do
    user = User.make
    user.groups.make(:sales)
    login user
  end

end
