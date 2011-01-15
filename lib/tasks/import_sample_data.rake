require 'import_sample_data'

desc 'import sample results'
task :import_sample_results => :environment do
  import_sample_results
end

desc 'import sample account_details'
task :import_sample_account_details => :environment do
  import_sample_account_details
end
