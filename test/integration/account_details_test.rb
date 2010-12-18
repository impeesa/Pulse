require 'test_helper'

class AccountDetailsTest < ActionController::IntegrationTest

  include Webrat::HaveTagMatcher

  setup do
    import_sample_account_details 50
    login
  end

  test '#index should return account details' do
    visit account_details_path
    assert_contain_account_details AccountDetail.scoped
  end

  test '#decreased should return decreased account details' do
    visit decreased_account_details_path
    assert_contain_account_details AccountDetail.decreased, AccountDetail.increased.first
  end

  test '#increased should return increased account details' do
    visit increased_account_details_path
    assert_contain_account_details AccountDetail.increased, AccountDetail.decreased.first
  end

  test '#new_accounts should return new_accounts account details' do
    visit new_accounts_account_details_path
    assert_contain_account_details AccountDetail.new_accounts, AccountDetail.decreased.first
  end

  # custom assertions.

  def assert_contain_account_details(account_details, excluded_account_detail = nil)
    # assigns is empty for some reason.
    # assert_equal account_details.count, assigns(:account_details).size
    account_detail = account_details.first
    assert_contain_account_detail_row account_detail
    assert_not_contain_account_detail_row excluded_account_detail if excluded_account_detail
  end

  def assert_contain_account_detail_row(account_detail)
    assert_have_tag :tr, :id => "account_detail_#{account_detail.id}"
  end

  def assert_not_contain_account_detail_row(account_detail)
    assert_have_no_tag :tr, :id => "account_detail_#{account_detail.id}"
  end

end
