Vivatjesus::Application.routes.draw do

  resources :sponsors

  resources :councils

  match '/calendar' => 'pages#calendar'
  # match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  match '/posts/rss' => 'posts#rss'
  match '/events/rss' => 'events#rss'
  match '/password/:id' => 'users#password'

  resources :events
  resources :posts
  resources :users
  resources :sessions

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  match '/login' => 'sessions#new'
  match '/logout' => 'sessions#destroy'
  match '/about' => 'pages#about'
  match '/join' => 'pages#join'
  match '/pages/contact' => 'pages#contact'
  match '/search' => 'posts#search'
  match '/mobile' => 'pages#mobile'
  match '/news' => 'pages#news'
  match '/raffle' => 'pages#raffle'
  match '/success' => 'pages#success'
  match '/payments' => 'pages#payments'
  match '/dues' => 'pages#dues'

  match '/mobile/home' => 'mobile#index'
  match '/mobile/about' => 'mobile#about'
  match '/mobile/news' => 'mobile#news'
  match '/mobile/calendar' => 'mobile#calendar'



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
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
