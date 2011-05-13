require 'charts'

namespace :charts do
  desc 'create charts'
  task :create => :environment do
    puts "creating charts..."
    create
    puts "created all charts."
  end

  desc 'remove all charts'
  task :remove_all => :environment do
    puts "removing charts..."
    remove_all_charts
    puts "removed all charts."
  end
end
