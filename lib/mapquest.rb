require 'net/http'
require 'nokogiri'
MAPQUEST_KEY = 'INSERT_YOUR_KEY_HERE'

class MapQuestRoute
  class Failure < StandardError; end

  attr_accessor :route, :info, :centrepoint, :locations, :bounding_box

  def initialize(targetlocations, routeType = "bicycle") #locations should be an array of 2-cell arrays
    @locations = targetlocations
    tlocations = targetlocations.map do |tl|
      {:latLng => {:lat => tl[0], :lng => tl[1]}}
    end
    request_body =  {:key => MAPQUEST_KEY, :locations => tlocations, :options => { :routeType => routeType } }
    response = RestClient.post 'open.mapquestapi.com/directions/v0/optimizedroute', request_body.to_json, {:content_type => :json}
    jresponse = JSON.parse(response)
    @route = jresponse["route"]
    @info  = jresponse["info"]
    self.bounding_box
    self.centrepoint
  end

  def centrepoint
    unless @locations.nil?
      midlat = @locations.inject(0) {|s,v| s += v[0]}/ @locations.count
      midlon = @locations.inject(0) {|s,v| s += v[1]}/ @locations.count
      @centrepoint = [midlat, midlon]    
    end
  end

  def bounding_box
    unless @locations.nil? 
      maxlat = @locations.map{ |l| l[0]}.max
      maxlon = @locations.map{ |l| l[1]}.max
      minlat = @locations.map{ |l| l[0]}.min
      minlon = @locations.map{ |l| l[1]}.min
      @bounding_box = [minlat, minlon, maxlat, maxlon]
    end
  end

  def get_map(size="800,800") #centre = @centrepoint.join(','), zoom=10)
    #RestClient.get "http://open.mapquestapi.com/staticmap/v3/getmap?session=#{@route["sessionId"]}&size=#{size}&center=#{centre}&zoom=#{zoom}"
    #puts "http://open.mapquestapi.com/staticmap/v3/getmap?key=#{MAPQUEST_KEY}&session=#{@route["sessionId"]}&size=#{size}&bestfit=#{@bounding_box.join(',')}"
    #RestClient.get "http://open.mapquestapi.com/staticmap/v3/getmap?key=#{MAPQUEST_KEY}&session=#{@route["sessionId"]}&size=#{size}&bestfit=#{@bounding_box.join(',')}"
    #doesn't like pipes
    pois = @locations.map{ |l| "a,#{l[0]},#{l[1]}" }.join("%7C") # %7C => |
    RestClient.get "http://open.mapquestapi.com/staticmap/v3/getmap?key=#{MAPQUEST_KEY}&session=#{@route["sessionId"]}&size=#{size}&pois=#{pois}&stops=#{pois}"
  end

end

