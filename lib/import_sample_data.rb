require 'fastercsv'

def import_sample_results
  file_path = Rails.root.join('sample_data/results.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end

def import_sample_account_details(limit = nil)
  file_path = Rails.root.join('sample_data/account_details.csv')
  csv_rows = FasterCSV.read(file_path, :headers => true)
  csv_rows = csv_rows.first(limit) if limit
  csv_rows.each do |csv_row|
    AccountDetail.create!(csv_row.to_hash)
  end
end
