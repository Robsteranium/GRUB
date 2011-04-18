class Delivery < ActiveRecord::Base

 # validates_with ConsistencyValidator
  belongs_to  :subscription
  belongs_to  :user
  belongs_to  :box
  has_many    :transactions, :dependent => :destroy
  
  after_save :create_transactions
  
  def create_transactions
    self.transactions.delete_all
    if self.delivered?      
      self.transactions << Transaction.create(:delivery_id => self.id, :user_id => self.user.id, :date => Time.now, :amount => -self.box.price, :source => "Purchased #{self.box.name} box")      
    end
    unless self.payment_collected.nil?
      self.transactions << Transaction.create(:delivery_id => self.id, :user_id => self.user.id, :date => Time.now, :amount => self.payment_collected, :source => "Paid in cash")            
    end    
  end
  
end

class ConsistencyValidator < ActiveModel::Validator
  def validate(record)
    unless record.user == record.subscription.user && record.box == record.subscription.box
      record.errors[:base] << "User/ Box for delivery is different from subscription"
    end
  end
end