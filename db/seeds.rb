# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create([{ :name => 'admin'},{ :name => 'guest'},{ :name => 'registered' }])
Box.create([{ :name => "Small", :price => 3.0, :description => "small box"}, { :name => "Big", :price => 5.0, :description => "big box"}])
Location.create(:lat => 53.4656906, :lng => -2.2564567, :name => "St Wilfs", :postcode => "M15 5BJ")