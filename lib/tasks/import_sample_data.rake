desc 'import sample data'
task :import_sample_data => :environment do
  require 'import_sample_data'
  import_sample_data
end
