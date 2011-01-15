# These methods originally existed in the AccountDetail class,
# but they were to be used in migrations, which causes Rails
# to load the class, which requires the table to exist,
# which can't be possible since that migration is there to create that table.
class AccountDetailGroups

  def self.column_groups
    @column_groups ||= %w{CYTD PYTD Var}.freeze
  end

  def self.column_sub_groups
    @column_subgroups ||= %w{A B C D E F Total}.freeze
  end

end
