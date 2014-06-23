class CreateTxns < ActiveRecord::Migration
  def change
    create_table :txns do |t|
      t.integer :amount, default: 0, null: false
      t.references :user, index: true
      t.datetime :created_at
    end
  end
end
