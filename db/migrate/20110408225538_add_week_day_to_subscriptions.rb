class AddWeekDayToSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :weekday, :integer
  end

  def self.down
    remove_column :subscriptions, :weekday
  end
end
