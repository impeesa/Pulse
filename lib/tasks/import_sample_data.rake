require 'import_sample_data'

desc 'import sample results'
task :import_sample_results => :environment do
  import_sample_results
end

desc 'import sample account_details'
task :import_sample_account_details => :environment do
  import_sample_account_details
end

desc 'create menu tabs list'
task :create_menu_tabs_list => :environment do 
  puts "creating..."
  create_menu_tabs_list
  puts "created menu tabs list."
end

desc 'Drop old DB, create new one, run migrate, run seeds, import sample data...'
task :give_me_everything => :environment do
  puts "Drop old DB, create new one, run migrate, run seeds, import sample data..."
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seeds'].invoke
  Rake::Task['import_sample_results'].invoke
  Rake::Task['import_sample_account_details'].invoke
  Rake::Task['create_menu_tabs_list'].invoke
  puts "Loaded everything."
end
