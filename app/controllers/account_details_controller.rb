class AccountDetailsController < ApplicationController

  def index
    @account_details = AccountDetail.by_branch_and_account_number
  end

  def decreased
    @account_details = AccountDetail.decreased
    render :index
  end

  def increased
    @account_details = AccountDetail.increased
    render :index
  end

  def new_accounts
    @account_details = AccountDetail.new_accounts
    render :index
  end

end
