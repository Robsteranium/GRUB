class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :user_id
      t.datetime :date
      t.float :amount
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
