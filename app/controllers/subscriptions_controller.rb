class SubscriptionsController < ApplicationController
  filter_access_to :all
  
  def index
    @subscriptions = Subscription.all
  end

  def roll_subscriptions
    session[:return_to] ||= request.referer
    Subscription.all.each do |subscription|
      subscription.extend_deliveries
    end
    flash[:notice] = "subscriptions rolled forward!"
    redirect_to session[:return_to]
  end

  def create
    session[:return_to] ||= request.referer
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save!
      flash[:notice] = "subscription added!"
    end
    redirect_to session[:return_to]
  end

  def destroy
    session[:return_to] ||= request.referer
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to session[:return_to]
  end

  def update
    session[:return_to] ||= request.referer
    @subscription = Subscription.find(params[:id])
    if @subscription.update_attributes(params[:subscription])
      flash[:notice] = "Subscription updated!"
    else
      flash[:error] = "Subscription updated!"
    end
    redirect_to session[:return_to]
  end

end
