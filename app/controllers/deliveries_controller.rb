class DeliveriesController < ApplicationController

  require 'get_dates'
  require 'mapquest'
  require 'reorder'
  
  respond_to :html, :json
  
  before_filter :get_delivery_date, :only => [:checklist, :route_map, :locations, :centrepoint, :missed_deliveries, :bike_map, :car_map]
  before_filter :route_map, :only => [:bike_map, :car_map]
    
  def calendar
    # next 4 weeks worth of drops
    horizon = params[:horizon].nil? ? 30 : params[:horizon].to_i
    @drop_dates = DateProcess.next(horizon)
    @old_dates =  DateProcess.last(horizon)
    @all_dates = @drop_dates + @old_dates
    @calendar = {}
    @all_dates.each do |delivery_date|
      @calendar[delivery_date] = Delivery.where(:date => delivery_date.to_date)
    end
  end

  def checklist #  printed out before doing the delivery run and filled-in once delivery is complete
    @deliveries = Delivery.where(:date => @delivery_date.to_date)
  end

  def setDeliveryStatus
    @delivery = Delivery.find(params[:delivery_id])
    @delivery.delivered = params[:status_to_set]
    @delivery.save!
    #respond_to do |format|
    #  format.js
    #end
    render :update do |page|
      page.replace_html "delivered_flag#{@delivery.id}".to_sym, :partial => 'selectDeliveryStatus', :object => @delivery
      page.replace_html "balance#{@delivery.id}".to_sym, :partial => 'userBalance', :object => @delivery
    end
  end
  
  def bike_map
    @map = MapQuestRoute.new(@locations, "bicycle")
    @deliveries = @deliveries.reorder( @map.route["locationSequence"][1..-1])
  end
  
  def car_map
    @map = MapQuestRoute.new(@locations, "fastest")
    @deliveries = @deliveries.reorder( @map.route["locationSequence"][1..-1])
  end

  def missed_deliveries
    @missed_deliveries = Delivery.where(:delivered => false, :date => @delivery_date)
  end

  def updateDeliveryResult
    @delivery = Delivery.find(params[:id][1..-1])
    @delivery.delivery_result = params[:value]
    @delivery.save
    render :text => params[:value]
  end
  
  def updatePayment
    @delivery = Delivery.find(params[:id][1..-1])
    @delivery.payment_collected = params[:value].to_f
    @delivery.save
    render :text => params[:value].to_f
  end

  def getBalance
    @delivery = Delivery.find(params[:delivery_id])
    render :text => @delivery.user.balance
  end

  def create
    session[:return_to] ||= request.referer
    @delivery = Delivery.new(params[:delivery])
    if @delivery.save!
      flash[:notice] = "Delivery added!"
    end
    redirect_to session[:return_to]
  end

  def destroy
    session[:return_to] ||= request.referer
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to session[:return_to]
  end

  private
    def get_delivery_date
      if params[:day].nil?
        @delivery_date = DateProcess.nextDrop
      else
        param_date = "#{params[:day]}/#{params[:month]}/#{params[:year]}"    
        @delivery_date = Date.strptime(param_date, "%d/%m/%Y")
      end
    end
    
    def route_map
      @deliveries = Delivery.where(:date => @delivery_date.to_date).where("delivered = ? OR delivered IS NULL", false) #assume all undelivered on the route map
      wilfs = Location.first
      @locations = []
      @locations << [wilfs.lat, wilfs.lng] # start...
      @deliveries.map{ |d| @locations << [d.user.location.lat, d.user.location.lng] }
      @locations << [wilfs.lat, wilfs.lng] # and end at St Wilfs
    end
end
