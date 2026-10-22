class AddMonthlyAllowanceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :monthly_allowance, :integer
  end
end
