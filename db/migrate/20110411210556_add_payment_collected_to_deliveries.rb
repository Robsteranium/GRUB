class AddPaymentCollectedToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :payment_collected, :float
  end

  def self.down
    remove_column :deliveries, :payment_collected
  end
end
