authorization do
  role :admin do
    includes :guest
    includes :registered
    has_permission_on :subscriptions, :to => [:roll_subscriptions, :manage]
    has_permission_on :deliveries, :to => [:calendar, :list, :return, :setDeliveryStatus, :missed_deliveries]
    has_permission_on :users, :to =>  [:balances, :index, :destroy, :showuser, :their_deliveries, :their_balance]
  end

  role :registered do
    has_permission_on :users, :to => [:edit, :update, :show, :my_deliveries, :my_balance]
    has_permission_on :subscriptions, :to => [:manage]
    
  end

  role :guest do
    has_permission_on :users, :to => [:new, :create]
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
