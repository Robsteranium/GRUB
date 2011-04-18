class Location < ActiveRecord::Base
 
  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lng

  belongs_to :user
  

end
