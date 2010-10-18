namespace :db do

  desc 'import example data'
  task :import_sample_data => :environment do
    require 'import_sample_data'
    import_sample_data
  end

end
