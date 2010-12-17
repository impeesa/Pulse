require 'fastercsv'

def import_sample_data
  file_path = Rails.root.join('sample_data/sample_data.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end

def import_account_detail_sample_data
  file_path = Rails.root.join('sample_data/account_detail.csv')
  FasterCSV.read(file_path, :headers => true).each do |csv_row|

  end
end
