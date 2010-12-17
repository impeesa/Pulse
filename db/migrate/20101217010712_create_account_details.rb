class CreateAccountDetails < ActiveRecord::Migration
  def self.up
    create_table :account_details do |t|
      t.string :branch
      t.integer :sp_number
      t.string :sp_name
      t.integer :account_number
      t.string :account_name
      AccountDetail.column_groups.each do |column_group|
        AccountDetail.column_sub_groups.each do |letter|
          t.float "#{column_group}_#{letter}"
        end
      end
    end
  end

  def self.down
    drop_table :account_details
  end
end
