class Box < ActiveRecord::Base
  validates_presence_of     :name
  validates_presence_of     :description
  validates_numericality_of :price
  has_many                  :subscriptions
  has_attached_file         :picture, :styles => {:medium => '200x200>', :thumb => "100x100>"}

end
