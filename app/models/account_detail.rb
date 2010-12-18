class AccountDetail < ActiveRecord::Base

  def self.column_groups
    @column_groups ||= %w{cytd pytd ytd_variance}.freeze
  end

  def self.column_sub_groups
    @column_subgroups ||= %w{a b c d e f total}.freeze
  end

  def self.number_columns
    @number_columns ||= column_groups.map do |column_group|
      column_sub_groups.map do |column_sub_group|
        "#{column_group}_#{column_sub_group}"
      end
    end.flatten.freeze
  end

  def self.non_number_columns
    column_names - number_columns
  end

  scope :by_branch_and_account_number, order('branch, account_number')
  scope :decreased, where('ytd_variance_total < 0').order('ytd_variance_total desc')
  scope :increased, where('ytd_variance_total > 0').order('ytd_variance_total')
  scope :new_accounts, where('pytd_total is null').order('ytd_variance_total')
  # Grouped by branch, sum each number column.
  # Select all columns as if it were a normal query.
  scope :summaries, group('branch').select((non_number_columns + number_columns.map { |column| "sum(#{column}) as #{column}" }).join(', ')).order('branch')

end
