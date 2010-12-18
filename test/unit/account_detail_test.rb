require 'test_helper'

class AccountDetailTest < ActiveSupport::TestCase

  test 'summaries scope returns objects with fields summed' do
    3.times do
      atts = AccountDetail.number_columns.inject({}) do |atts_hash, column|
        atts_hash[column] = 1
        atts_hash
      end
      AccountDetail.create! atts
    end
    account_detail = AccountDetail.summaries.first
    assert_nothing_raised do
      AccountDetail.number_columns.each do |column|
        raise unless 3 == account_detail.send(column)
      end
    end
    assert_equal AccountDetail.column_names.sort, account_detail.attributes.keys.sort
  end

end
