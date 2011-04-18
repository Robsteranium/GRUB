class User < ActiveRecord::Base
  acts_as_authentic

  has_many  :deliveries, :order => 'date DESC'
  has_many  :subscriptions
  has_many  :transactions
  has_many  :assignments
  has_many  :roles, :through => :assignments

  include Geokit::Geocoders
  has_one :location
  validates_presence_of :postcode
  after_create :make_location

  def balance
    self.transactions.inject(0) { |s,t| s += t.amount }
  end

  def make_location
    @geo = MultiGeocoder.geocode(postcode)
    @loc = Location.new 
    @loc.lat = @geo.lat
    @loc.lng = @geo.lng
    @loc.name = username
    @loc.postcode = postcode
    @loc.street = address
    @loc.user_id = id
    if location
      location.delete
    end
    @loc.save
  end

  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  def self.find_by_username_or_email(login)
    User.find_by_username(login) || User.find_by_email(login)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Postoffice.deliver_password_reset_instructions(self)
  end


end
