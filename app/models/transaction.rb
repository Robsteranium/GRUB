class Transaction < ActiveRecord::Base
  validates_presence_of :amount
  validates_presence_of :date
  belongs_to            :user
  belongs_to            :delivery # if debit
#  belongs_to            :palpal... # if crebit
  
end
