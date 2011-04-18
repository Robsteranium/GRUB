class UsersController < ApplicationController
  filter_access_to :all #, :except => [:new, :create]
#  before_filter :require_no_user, :only => [:new, :create]
#  before_filter :require_user, :only => [:show, :edit, :update]
#  before_filter :require_user, :only => [:showuser, :flipadmin, :index]

  def balances
    @user = User.all.sort_by{|u| u.balance }
  end

  def my_deliveries
    @user = current_user
    @deliveries = Delivery.where(:user_id => @user.id).where("date > ?", Time.now)
    @delivery = Delivery.new
    @box_options = Box.all.map{|b| [b.name, b.id]}
    @day_options = [["Thursday",4],["Friday",5]]
    @intervals = [["Weekly",7],["Fortnightly",14]]
    @subscriptions = @user.subscriptions
    @newsubscription = Subscription.new
  end
  
  def their_deliveries
    @user = User.find(params[:user_id])
    @deliveries = Delivery.where(:user_id => @user.id).where("date > ?", Time.now)
    @delivery = Delivery.new
    @box_options = Box.all.map{|b| [b.name, b.id]}
    @day_options = [["Thursday",4],["Friday",5]]
    @intervals = [["Weekly",7],["Fortnightly",14]]
    @subscriptions = @user.subscriptions
    @newsubscription = Subscription.new
    render :action => :my_deliveries
  end

  def my_balance
    @user = current_user
    @transactions = Transaction.where(:user_id => @user.id)
  end

  def their_balance
    @user = User.find(params[:user_id])
    @transactions = Transaction.where(:user_id => @user.id)
    render :action => :my_balance
  end


  # send balance reminder (you owe us £x etc)
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name('registered')
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default "/"
    else
      render :action => :new
    end
  end
    
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to "/"
    else
      render :action => :edit
    end
  end

  def show
    @user = @current_user
  end

  def showuser
    @user = User.find(params[:id])
    render :action => :show
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def flipadmin
    @user = User.find(params[:id])
    if @user.role_symbols.include?(:admin)
      if @user.roles.delete(Role.find_by_name('admin'))
        flash[:notice] = "User admin role unassigned!"   
      else
        flash[:notice] = "Failed to unassign admin role!"
      end
    else
      if @user.roles << Role.find_by_name('admin')
        flash[:notice] = "User admin role assigned!"
      else
        flash[:notice] = "Failed to assign admin role!"
      end
    end
    redirect_to :action => :index
  end

end