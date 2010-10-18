desc 'import example data'
task :import_sample_data => :environment do
  require 'csv'
  file_path = Rails.root.join('sample_data.csv')
  CSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end
