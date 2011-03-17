# if you're running Ruby 1.9, use 'csv' instead. 
# csv is a part of Ruby 1.9 and equal to fastercsv in Ruby 1.8
# csv gem used for Ruby 1.8 is something quite different - Giang Nguyen.

#require 'fastercsv'
require 'csv'

def import_sample_results
  file_path = Rails.root.join('sample_data/results.csv')
  #FasterCSV.read(file_path, :headers => true).each do |csv_row|
  CSV.read(file_path, :headers => true).each do |csv_row|
    Result.create!(csv_row.to_hash)
  end
end

def import_sample_account_details(limit = nil)
  file_path = Rails.root.join('sample_data/account_details.csv')
  #csv_rows = FasterCSV.read(file_path, :headers => true)
  csv_rows = CSV.read(file_path, :headers => true)
  csv_rows = csv_rows.first(limit) if limit
  csv_rows.each do |csv_row|
    AccountDetail.create!(csv_row.to_hash)
  end
end

def create_menu_tabs_list
  ['Results', 'Account details', 'NPS', 'Administrator'].each do |t|
    tab = Tab.create(:name => t)
    GroupTab.create(:group_id => Group.find_by_name('Admin').id, :tab_id => tab.id)
  end
end

def import_sample_comments
  file = File.open('sample_data/nps_comments.rpt')
  headers = []
  file.each_with_index do |line, line_number|
    if line_number == 0
      headers = line.chop!.slice(1, line.length).split(/\t/)
      headers.each { |h| h.downcase! }
    else
      values = line.chop!.split(/\t/)
      comment = {}
      headers.each_with_index do |h, i| 
        value = values[i]
        value = value.to_f if h.to_sym == :score
        comment.merge!(h.to_sym => value)
      end
      puts comment
      Comment.create(comment)
    end
  end
end
