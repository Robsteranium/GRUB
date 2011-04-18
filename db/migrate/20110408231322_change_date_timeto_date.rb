class ChangeDateTimetoDate < ActiveRecord::Migration
  def self.up
    remove_column :deliveries, :date
    add_column    :deliveries, :date, :date
  end

  def self.down
    remove_column :deliveries, :date
    add_column    :deliveries, :date, :datetime
  end
end
