Grub::Application.routes.draw do

  match 'deliveries/checklist' => 'deliveries#checklist'
  match 'deliveries/calendar' => 'deliveries#calendar'
  match 'deliveries/missed_deliveries' => 'deliveries#missed_deliveries'
  match 'deliveries/bike_map' => 'deliveries#bike_map'
  match 'deliveries/car_map' => 'deliveries#car_map'
  
  get "deliveries/setDeliveryStatus"
  post "deliveries/updatePayment"
  post "deliveries/updateDeliveryResult"
  get "deliveries/getBalance"
  get "subscriptions/roll_subscriptions"
  get "users/flipadmin"
  get "users/showuser"
  
  resources :deliveries
  resources :subscriptions
  
  match 'users/balances' => 'users#balances'

  match 'my_deliveries' => 'users#my_deliveries'
  match 'my_balance' => 'users#my_balance'
  get 'users/their_deliveries'
  get 'users/their_balance'

  resource :account, :controller => "users"
  resources :users
  
  resource :user_session
  root :controller => "user_sessions", :action => "new" # optional, this just sets the root route
  resources :password_resets

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
