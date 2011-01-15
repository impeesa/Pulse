require 'test_helper'

class ChartJavascriptsControllerTest < ActionController::TestCase

  test 'js responses' do
    Chart.names.each do |name|
      get name, :format => 'js'
      assert_response :success
    end
  end

end
