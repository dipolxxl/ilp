class ChangeAmountDefaultValueInTxns < ActiveRecord::Migration
  def up
    change_column :txns, :amount, :integer, null: false, default: 1
  end

  def down
    change_column :txns, :amount, :integer, null: false, default: 0
  end
end
