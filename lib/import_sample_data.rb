require 'fastercsv'

def import_sample_results
  file_path = Rails.root.join('sample_data/results.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end

def import_sample_account_details
  file_path = Rails.root.join('sample_data/account_details.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|
    AccountDetail.create!(csv_row.to_hash)
  end
end
