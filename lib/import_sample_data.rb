require 'fastercsv'

def import_sample_data
  file_path = Rails.root.join('sample_data.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end
