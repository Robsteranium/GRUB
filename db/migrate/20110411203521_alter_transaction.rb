class AlterTransaction < ActiveRecord::Migration
  def self.up
    add_column :transactions, :delivery_id, :integer
  end

  def self.down
    remove_column :transactions, :delivery_id
  end
end
