class CreateTbl0utputSpos < ActiveRecord::Migration
  def self.up
    create_table :tbl_Output_SPOS do |t|
      t.float :Region
      t.string :Report_name
      t.string :Myers_BranchID
      t.integer :Sales_ID
      t.string :Sales_Name
      t.integer :Customer_No
      t.string :Customer_Name
      AccountDetailGroups.column_groups.each do |column_group|
        AccountDetailGroups.column_sub_groups.each do |sub_group|
          t.float "#{column_group}_Qty_#{sub_group}"
        end
      end
      t.float :WeekNum_ID
    end
  end

  def self.down
    drop_table :tbl_Output_SPOS
  end
end
