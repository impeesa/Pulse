class AccountDetailsController < ApplicationController
  before_filter :load_account_details, :check_permission

  def index
    @account_details = @account_details.by_branch_and_account_number
  end

  def decreased
    @account_details = @account_details.decreased
    render :index
  end

  def increased
    @account_details = @account_details.increased
    render :index
  end

  def new_accounts
    @account_details = @account_details.new_accounts
    render :index
  end

  def summaries
    @account_details = @account_details.summaries
    render :index
  end

  protected

  def load_account_details
    @week = params[:week]
    if @week.present?
      @account_details = AccountDetail.where(:WeekNum_ID => @week)
    else
      @account_details = AccountDetail.scoped({})
    end
  end

  def check_permission
    render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Account details')
  end
end
