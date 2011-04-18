class Subscription < ActiveRecord::Base

  belongs_to :user  
  belongs_to :box
  has_many   :deliveries, :order => 'date ASC', :dependent => :destroy
  
  require 'get_dates'
    
  def extend_deliveries
    if self.deliveries.empty?
      delivery_date = DateProcess.getLast(self.weekday)
    else
      delivery_date = self.deliveries.last.date
    end
    4.times do  # extends for 4 more deliveries
      delivery_date += self.interval.days
      Delivery.create(:user_id => self.user_id, :box_id => self.box_id, :subscription_id => self.id, :date => delivery_date.to_date)
    end
  end

  def refresh_deliveries
    # shouldn't delete deliveries already marked as delivered/ paymented collected
    self.deliveries.where("date > ?", Time.now).delete_all  
    self.extend_deliveries
  end

  after_save { self.refresh_deliveries }
  
end
