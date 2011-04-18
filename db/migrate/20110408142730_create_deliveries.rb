class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :user_id
      t.integer :box_id
      t.integer :subscription_id
      t.boolean :delivered
      t.string  :delivery_result
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
