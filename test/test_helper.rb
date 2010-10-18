ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webrat'
Webrat.configure do |config|
  config.mode = :rack
end

require 'import_sample_data'

class ActiveSupport::TestCase
end
