class AccountDetail < ActiveRecord::Base

  set_table_name :tbl_Output_SPOS

  # Columns that belong to column_groups (CTYD, PYTD, Var).
  def self.number_columns
    @number_columns ||= AccountDetailGroups.column_groups.map do |column_group|
      AccountDetailGroups.column_sub_groups.map do |column_sub_group|
        "#{column_group}_Qty_#{column_sub_group}"
      end
    end.flatten.freeze
  end

  def self.non_number_columns
    column_names - number_columns
  end

  scope :by_branch_and_account_number, order('Myers_BranchID, Sales_ID')
  scope :decreased, where('Var_Qty_Total < 0').order('Var_Qty_Total desc')
  scope :increased, where('Var_Qty_Total > 0').order('Var_Qty_Total')
  scope :new_accounts, where('PYTD_Qty_Total is null').order('Var_Qty_Total')
  # Grouped by branch, sum each number column.
  # Select all columns as if it were a normal query.
  scope :summaries, group('Myers_branchID').select((non_number_columns + number_columns.map { |column| "sum(#{column}) as #{column}" }).join(', ')).order('Myers_BranchID')

  def self.weeks
    order(:WeekNum_ID).map(&:WeekNum_ID).uniq
  end

end
