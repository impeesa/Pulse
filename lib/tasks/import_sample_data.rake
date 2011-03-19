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

desc 'import sample comments'
task :import_sample_comments => :environment do
  puts "importing..."
  import_sample_comments
  puts "imported sample comments."
end

desc 'import sample scores'
task :import_sample_scores => :environment do
  puts "importing scores..."
  import_sample_scores
  puts "imported scores."
end

desc 'Drop old DB, create new one, run migrate, run seeds, import sample data...'
task :give_me_everything => :environment do
  puts "Drop old DB, create new one, run migrate, run seeds, import sample data..."
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  Rake::Task['import_sample_results'].invoke
  Rake::Task['import_sample_account_details'].invoke
  Rake::Task['import_sample_comments'].invoke
  Rake::Task['import_sample_scores'].invoke
  #Rake::Task['create_menu_tabs_list'].invoke # need to run rake create_menu_tabs_list alone, dont know why - Giang NGUYEN.
  puts "Loaded everything."
end
